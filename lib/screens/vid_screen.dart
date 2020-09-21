import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_active_prf/data/percentage_logic.dart';
import 'package:get_active_prf/screens/test.dart';
import 'package:get_active_prf/services/database_service.dart';
import 'package:get_active_prf/styles/decorations.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

var globalContext;

class VidScreen extends StatefulWidget {
  final List<dynamic> ids;
  final String weekNo;
  final String version;
  final String dayNo;
  VidScreen({this.ids, this.weekNo, this.version, this.dayNo});
  @override
  _VidScreenState createState() => _VidScreenState();
}

class _VidScreenState extends State<VidScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  YoutubePlayerController _controller;
  TextEditingController _idController;
  TextEditingController _seekToController;

  YoutubeMetaData currentId;
  PlayerState _playerState;
  YoutubeMetaData _videoMetaData;
  bool _isPlayerReady = false;
  List<dynamic> _ids = [];
  @override
  void initState() {
    super.initState();
    setState(() {
      _ids = this.widget.ids;
    });
    _controller = YoutubePlayerController(
      initialVideoId: _ids.first,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    _idController = TextEditingController();
    _seekToController = TextEditingController();
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }

  int get totalnum {
    return _ids.length;
  }

  int get dayno {
    return int.parse(widget.dayNo) - 1;
  }

  int finished = 0;
  double unFinished = 0;
  PrcntgLogic progressprcntg;
  DatabaseService databaseService = DatabaseService();
  @override
  Widget build(BuildContext context) {
    final prcntgeProvider = Provider.of<PrcntgLogic>(context, listen: true);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              showDialog(
                    context: context,
                    builder: (context) => new AlertDialog(
                      title: new Text('Are you sure?'),
                      content: new Text('Do you want to exit an App'),
                      actions: <Widget>[
                        new GestureDetector(
                          onTap: () => Navigator.of(context).pop(false),
                          child: Text("NO"),
                        ),
                        SizedBox(height: 16),
                        new GestureDetector(
                          onTap: () async {
                            _controller.pause();
                            setState(() {
                              unFinished += ((_controller
                                          .metadata.duration.inSeconds -
                                      (_controller.metadata.duration.inSeconds -
                                          _controller
                                              .value.position.inSeconds)) /
                                  _controller.metadata.duration.inSeconds);
                            });
                            prcntgeProvider.getPrsntg(
                                this.finished,
                                this.unFinished,
                                this.totalnum,
                                'week${this.widget.weekNo}',
                                this.dayno);
                            _controller.pause();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TestScreen(
                                        weekNo: this.widget.weekNo,
                                        version: this.widget.version)));
                          },
                          child: Text("YES"),
                        ),
                      ],
                    ),
                  ) ??
                  false;
            },
          ),
        ),
        body: YoutubePlayerBuilder(
          onExitFullScreen: () {
            // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
            SystemChrome.setPreferredOrientations(DeviceOrientation.values);
          },
          player: YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.blueAccent,
            bottomActions: [CurrentPosition()],
            topActions: <Widget>[
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  _controller.metadata.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.settings,
                  color: Colors.white,
                  size: 25.0,
                ),
                onPressed: () {
                  log('Settings Tapped!');
                },
              ),
            ],
            onReady: () {
              _isPlayerReady = true;
            },
            onEnded: (data) {
              setState(() {
                finished += 1;
              });
              if ((_ids.indexOf(_videoMetaData.videoId) + 1) < _ids.length) {
                _controller.load(_ids[(_ids.indexOf(data.videoId) + 1)]);
                _showSnackBar('Next Video Started!');
              } else {
                prcntgeProvider.getPrsntg(this.finished, this.unFinished,
                    this.totalnum, 'week${this.widget.weekNo}', this.dayno);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TestScreen(
                            weekNo: this.widget.weekNo,
                            version: this.widget.version)));
              }
            },
          ),
          builder: (context, player) => Scaffold(
            key: _scaffoldKey,
            body: ListView(
              children: [
                player,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 120,
                      ),
                      GestureDetector(
                        onTap: () {
                          if ((_ids.indexOf(_videoMetaData.videoId) + 1) <
                              _ids.length) {
                            _controller.pause();
                            print(this.dayno);
                            setState(() {
                              unFinished += ((_controller
                                          .metadata.duration.inSeconds -
                                      (_controller.metadata.duration.inSeconds -
                                          _controller
                                              .value.position.inSeconds)) /
                                  _controller.metadata.duration.inSeconds);
                            });
                            prcntgeProvider.getPrsntg(
                                this.finished,
                                this.unFinished,
                                this.totalnum,
                                'week${this.widget.weekNo}',
                                this.dayno);
                            _controller.load(_ids[
                                (_ids.indexOf(_videoMetaData.videoId) + 1)]);
                            _showSnackBar('Next Video Started!');
                          }
                        },
                        child: Container(
                          child: ((_ids.indexOf(_videoMetaData.videoId) + 1) <
                                  _ids.length)
                              ? Image.network(
                                  'https://img.youtube.com/vi/${_ids[_ids.indexOf(_videoMetaData.videoId) + 1]}/maxresdefault.jpg',
                                  fit: BoxFit.contain,
                                )
                              : Text('well Done!'),
                          width: MediaQuery.of(context).size.width / 2,
                          height:
                              (MediaQuery.of(context).size.width / 3.0) * 2.5,
                          decoration: shadedboxdecoration.copyWith(
                              color: Colors.pinkAccent.withOpacity(0.3)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void _showSnackBar(String message) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 16.0,
          ),
        ),
        backgroundColor: Colors.blueAccent,
        behavior: SnackBarBehavior.floating,
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
    );
  }
}

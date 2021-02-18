import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_active_prf/data/percentage_logic.dart';
import 'package:get_active_prf/screens/DayScreen.dart';
import 'package:get_active_prf/screens/explore.dart';
import 'package:get_active_prf/services/database_service.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get_active_prf/services/cloud_data.dart';

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

  List get progress_list {
    return List.filled(_ids.length, 0);
  }

  int get dayno {
    return int.parse(widget.dayNo) - 1;
  }

//variables to count day progress
  int finished = 0;
  double unFinished = 0;
  PrcntgLogic progressprcntg;
  DatabaseService databaseService = DatabaseService();
  @override
  Widget build(BuildContext context) {
    final prcntgeProvider = Provider.of<PrcntgLogic>(context, listen: true);
    return GestureDetector(
      onPanUpdate: (details) {
        //when user swipes => require confirmation from user to pop screen .
        if (details.delta.dx > 0) {
          showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              backgroundColor: Color(0xffF7F7F7),
              title: new Text('Are you sure?',
                  style: TextStyle(
                      fontSize: 21,
                      fontFamily: 'mija',
                      color: Colors.black.withOpacity(0.8))),
              content: new Text('Do you want to exit this workout session?',
                  style: TextStyle(
                      fontSize: 21,
                      fontFamily: 'mija',
                      color: Colors.black.withOpacity(0.8))),
              actions: <Widget>[
                new GestureDetector(
                  onTap: () => Navigator.of(context).pop(false),
                  child: Text("NO",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'mija',
                          color: Colors.black.withOpacity(0.7))),
                ),
                SizedBox(height: 16),
                new GestureDetector(
                  onTap: () async {
                    _controller.pause();

                    setState(() {
                      unFinished += ((_controller.metadata.duration.inSeconds -
                              (_controller.metadata.duration.inSeconds -
                                  _controller.value.position.inSeconds)) /
                          _controller.metadata.duration.inSeconds);
                    });

                    if (unFinished != null) {
                      //calling the get percentagefunction (how much of the video was played by user) after quitting video.
                      prcntgeProvider.getPrsntg(
                          this.finished,
                          this.unFinished,
                          this.totalnum,
                          'week${this.widget.weekNo}',
                          this.dayno);
                    }
                    //retrieve week video ids from cloud firestore to pass it back to Day Screen
                    Stream mystream =
                        CloudData().getweeksstream(this.widget.weekNo);
                    int current = await DatabaseService().getcurrentday();
                    Navigator.of(context).popUntil((route) => route.isFirst);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DayScreen(
                                dayNo: current.toString(),
                                week: mystream,
                                weekNo: this.widget.weekNo)));
                    _controller.reset();
                  },
                  child: Text("YES",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'mija',
                          color: Colors.black.withOpacity(0.7))),
                ),
              ],
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Color(0xffF7F7F7),
        body: YoutubePlayerBuilder(
          onExitFullScreen: () {
            // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
            SystemChrome.setPreferredOrientations(DeviceOrientation.values);
          },
          player: YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.white,
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
              SizedBox(height: 10),
              FullScreenButton(
                controller: _controller,
                color: Colors.white,
              ),
            ],
            onReady: () {
              _isPlayerReady = true;
            },
            onEnded: (data) async {
              setState(() {
                finished += 1;
              });
              if ((_ids.indexOf(_videoMetaData.videoId) + 1) < _ids.length) {
                _controller.load(_ids[(_ids.indexOf(data.videoId) + 1)]);
                _showSnackBar('Next Video Started!');
              } else {
                if (unFinished != null) {
                  prcntgeProvider.getPrsntg(
                      this.finished,
                      this.unFinished,
                      this.totalnum,
                      'week${this.widget.weekNo}',
                      int.parse(this.widget.dayNo));
                }
                //retrieve week video ids from cloud firestore to pass it back to Day Screen
                Stream mystream =
                    CloudData().getweeksstream(this.widget.weekNo);
                int current = await DatabaseService().getcurrentday();

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((current + 1) % 7) == 0
                            ? (context) => Explore()
                            : (context) => DayScreen(
                                  dayNo: ((current + 1) % 7).toString(),
                                  week: mystream,
                                  weekNo: this.widget.weekNo,
                                )));
              }
            },
          ),
          builder: (context, player) => Scaffold(
            backgroundColor: Color(0xffF7F7F7),
            bottomNavigationBar: BottomAppBar(
              color: Color(0xffF7F7F7),
              child: GestureDetector(
                onTap: () {
                  if ((_ids.indexOf(_videoMetaData.videoId)) + 1 < totalnum) {
                    _controller.pause();

                    setState(() {
                      unFinished += ((_controller.metadata.duration.inSeconds -
                              (_controller.metadata.duration.inSeconds -
                                  _controller.value.position.inSeconds)) /
                          _controller.metadata.duration.inSeconds);
                    });

                    if (unFinished != null) {
                      prcntgeProvider.getPrsntg(
                          this.finished,
                          this.unFinished,
                          this.totalnum,
                          'week${this.widget.weekNo}',
                          this.dayno);
                    }
                    _controller
                        .load(_ids[(_ids.indexOf(_videoMetaData.videoId)) + 1]);
                    _showSnackBar(
                      'Next Video Started!',
                    );
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: Container(
                    color: Color(0xffF7F7F7),
                    child: ((_ids.indexOf(_videoMetaData.videoId) + 1) <
                            totalnum)
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: CachedNetworkImage(
                              imageUrl:
                                  'https://img.youtube.com/vi/${_ids[_ids.indexOf(_videoMetaData.videoId) + 1]}/maxresdefault.jpg',
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          )
                        : ((_ids.indexOf(_videoMetaData.videoId) + 1) ==
                                totalnum)
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                    child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      0.0, 0.0, 0.0, 100.0),
                                  child: Text('well Done!',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 26,
                                          fontFamily: 'mija',
                                          color:
                                              Colors.black.withOpacity(0.3))),
                                )))
                            : Center(
                                child: Text('well Done!',
                                    style: TextStyle(
                                        fontSize: 36,
                                        fontFamily: 'mija',
                                        color: Colors.black.withOpacity(0.3)))),
                  ),
                ),
              ),
            ),
            key: _scaffoldKey,
            body: Column(
              children: [
                player,
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showSnackBar(String message) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 36,
              fontFamily: 'mija',
              color: Colors.black.withOpacity(0.3)),
        ),
        backgroundColor: Colors.white,
        behavior: SnackBarBehavior.floating,
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
    );
  }
}

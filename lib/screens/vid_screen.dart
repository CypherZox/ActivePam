import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_active_prf/screens/test.dart';
import 'package:get_active_prf/styles/decorations.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

var globalContext;

class VidScreen extends StatefulWidget {
  final List<dynamic> ids;
  final String weekNo;
  final String version;
  VidScreen({this.ids, this.weekNo, this.version});
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
  double _volume = 100;
  bool _muted = false;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: YoutubePlayerBuilder(
          onExitFullScreen: () {
            // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
            SystemChrome.setPreferredOrientations(DeviceOrientation.values);
          },
          player: YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.blueAccent,
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
              if ((_ids.indexOf(_videoMetaData.videoId) + 1) < _ids.length) {
                _controller.load(_ids[(_ids.indexOf(data.videoId) + 1)]);
                _showSnackBar('Next Video Started!');
              } else {
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
                          // print(_ids[_ids.indexOf(_videoMetaData.videoId) + 1]);
                          _controller.pause();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TestScreen(
                                      weekNo: this.widget.weekNo,
                                      version: this.widget.version)));
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

  Widget _text(String title, String value) {
    return RichText(
      text: TextSpan(
        text: '$title : ',
        style: const TextStyle(
          color: Colors.blueAccent,
          fontWeight: FontWeight.bold,
        ),
        children: [
          TextSpan(
            text: value ?? '',
            style: const TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStateColor(PlayerState state) {
    switch (state) {
      case PlayerState.unknown:
        return Colors.grey[700];
      case PlayerState.unStarted:
        return Colors.pink;
      case PlayerState.ended:
        return Colors.red;
      case PlayerState.playing:
        return Colors.blueAccent;
      case PlayerState.paused:
        return Colors.orange;
      case PlayerState.buffering:
        return Colors.yellow;
      case PlayerState.cued:
        return Colors.blue[900];
      default:
        return Colors.blue;
    }
  }

  Widget get _space => const SizedBox(height: 10);

  Widget _loadCueButton(String action) {
    return Expanded(
      child: MaterialButton(
        color: Colors.blueAccent,
        onPressed: _isPlayerReady
            ? () {
                if (_idController.text.isNotEmpty) {
                  var id = YoutubePlayer.convertUrlToId(
                    _idController.text,
                  );
                  if (action == 'LOAD') _controller.load(id);
                  if (action == 'CUE') _controller.cue(id);
                  FocusScope.of(context).requestFocus(FocusNode());
                } else {
                  _showSnackBar('Source can\'t be empty!');
                }
              }
            : null,
        disabledColor: Colors.grey,
        disabledTextColor: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14.0),
          child: Text(
            action,
            style: const TextStyle(
              fontSize: 18.0,
              color: Colors.white,
              fontWeight: FontWeight.w300,
            ),
            textAlign: TextAlign.center,
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
//  Column(
//   children: [
//     Container(
//       width: MediaQuery.of(context).size.width,
//       height: 250,
//       color: Colors.pink.withOpacity(0.1),
//     ),
//     SizedBox(
//       height: 100,
//     ),
//     Text(
//       'Coming next',
//       style: TextStyle(
//           color: Colors.grey[800],
//           fontSize: 30,
//           fontWeight: FontWeight.w600),
//     ),
//     SizedBox(
//       height: 25,
//     ),
//     Container(
//       width: MediaQuery.of(context).size.width / 3.6,
//       height: (MediaQuery.of(context).size.width / 5.0) * 2.5,
//       decoration: shadedboxdecoration.copyWith(
//           color: Colors.pinkAccent.withOpacity(0.3)),
//     ),
//   ],
// ),

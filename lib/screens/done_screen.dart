import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';

class Done extends StatefulWidget {
  @override
  _DoneState createState() => _DoneState();
}

class _DoneState extends State<Done> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 200,
          ),
          Center(
            child: Icon(
              FluentSystemIcons.ic_fluent_checkmark_filled,
              size: 68,
              color: Colors.green.withOpacity(0.7),
            ),
          ),
          SizedBox(
            height: 9,
          ),
          Text(
            'Done!',
            style: TextStyle(
              fontSize: 34,
              color: Colors.green.withOpacity(0.7),
            ),
          ),
          Text(
            'See you Tommorrow',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w300,
              color: Colors.green.withOpacity(0.5),
            ),
          ),
          SizedBox(height: 260),
          Column(
            children: [Text('Follow Pamela on'), Row()],
          ),
        ],
      ),
    );
  }
}

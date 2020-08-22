// login and register button

import 'package:flutter/material.dart';

class LRButton extends StatelessWidget {
  final String title;
  final Function onPressed;
  final double width;
  LRButton({@required this.onPressed, this.title, this.width});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.0),
      child: MaterialButton(
        color: Colors.white,
        elevation: 2.0,
        onPressed: onPressed,
        minWidth: width,
        height: 36.0,
        child: Text(
          title,
          style: TextStyle(
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}

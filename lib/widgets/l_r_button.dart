// login and register button

import 'package:flutter/material.dart';

// login & register button
class LRButton extends StatelessWidget {
  final String title;
  final Function onPressed;
  final double width;
  LRButton({@required this.onPressed, this.title, this.width});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.0),
      child: MaterialButton(
        color: Colors.white,
        elevation: 2.0,
        onPressed: onPressed,
        minWidth: width,
        height: 46.0,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 17,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}

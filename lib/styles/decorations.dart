import 'package:flutter/material.dart';

const inputdecoration = InputDecoration(
  hintText: 'Enter a value',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(17.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black12, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(17.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black12, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(17.0)),
  ),
);
var shadedboxdecoration = BoxDecoration(
    color: Colors.black,
    boxShadow: [
      BoxShadow(
          offset: Offset(3, 3),
          color: Colors.grey.withOpacity(0.4),
          spreadRadius: 2.0,
          blurRadius: 4.0)
    ],
    borderRadius: BorderRadius.circular(9));

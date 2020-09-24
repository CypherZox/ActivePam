import 'package:flutter/material.dart';

var inputdecoration = InputDecoration(
    labelText: 'Your E-mail',
    labelStyle:
        TextStyle(color: Colors.black.withOpacity(0.3), fontFamily: 'mija'),
    enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.black, width: 1.6)),
    focusedBorder:
        UnderlineInputBorder(borderSide: BorderSide(color: Colors.black54)),
    border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)));
var shadedboxdecoration = BoxDecoration(
  color: Colors.black,
  boxShadow: [
    BoxShadow(
        offset: Offset(3, 3),
        color: Colors.grey.withOpacity(0.4),
        spreadRadius: 2.0,
        blurRadius: 4.0)
  ],
  borderRadius: BorderRadius.circular(9),
);

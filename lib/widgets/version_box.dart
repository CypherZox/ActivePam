import 'package:flutter/material.dart';
import 'package:get_active_prf/styles/decorations.dart';

class VersionBox extends StatelessWidget {
  final String title;
  final Color color;
  final double sizeRation;
  VersionBox({this.color, this.sizeRation, this.title});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        child: Center(
          child: Text(title),
        ),
        padding: EdgeInsets.symmetric(horizontal: 7.0),
        width: MediaQuery.of(context).size.width / sizeRation,
        height: MediaQuery.of(context).size.width / sizeRation,
        decoration: shadedboxdecoration.copyWith(color: color),
      ),
    );
  }
}

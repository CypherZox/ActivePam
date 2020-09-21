import 'package:flutter/material.dart';

import 'package:get_active_prf/screens/test.dart';
import 'package:get_active_prf/styles/decorations.dart';

class VersionBox extends StatelessWidget {
  final String weekNo;
  final String title;
  final Color color;
  final double sizeRation;
  VersionBox({this.weekNo, this.color, this.sizeRation, this.title});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('tapped');
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TestScreen(
                      weekNo: weekNo,
                      version: title.replaceAll(new RegExp(r"\s+\b|\b\s"), ""),
                    )));
        String titlev = title.replaceAll(new RegExp(r"\s+\b|\b\s"), "");
        print('$titlev  $weekNo');
      },
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

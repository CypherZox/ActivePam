import 'package:flutter/material.dart';
import 'package:get_active_prf/styles/decorations.dart';

class DayNumber extends StatelessWidget {
  final String no;
  final Function numberChosen;
  DayNumber({this.no, this.numberChosen});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: numberChosen,
      child: Padding(
        padding: const EdgeInsets.only(top: 14),
        child: Container(
          child: Center(
            child: Text(
              no,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ),
          alignment: Alignment.topLeft,
          height: 47,
          width: 47,
          decoration: shadedboxdecoration.copyWith(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(9.0),
                  bottomRight: Radius.circular(9.0)),
              color: Colors.white,
              border: Border.all(width: 1, color: Colors.grey)),
        ),
      ),
    );
  }
}

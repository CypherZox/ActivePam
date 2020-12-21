import 'package:flutter/material.dart';
import 'package:get_active_prf/styles/decorations.dart';

class DayNumber extends StatelessWidget {
  final String no;
  final Function numberChosen;
  Color mycolor = Colors.black;
  DayNumber({
    this.no,
    this.numberChosen,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: MaterialButton(
        minWidth: 0,
        padding: EdgeInsets.all(0),
        onPressed: () {
          numberChosen();
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 14),
          child: Container(
            child: RotatedBox(
              quarterTurns: -1,
              child: Text(
                no,
                style:
                    TextStyle(color: mycolor, fontFamily: 'mija', fontSize: 15),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

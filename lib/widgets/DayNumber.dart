import 'package:flutter/material.dart';
import 'package:get_active_prf/screens/DayScreen.dart';

class DayNumber extends StatefulWidget {
  final String no;
  final Function numberChosen;
  final Color mycolor;

  DayNumber({this.no, this.numberChosen, this.mycolor});

  @override
  _DayNumberState createState() => _DayNumberState();
}

class _DayNumberState extends State<DayNumber> {
  @override
  Widget build(BuildContext context) {
    List<bool> isSelected = List.generate(7, (index) => false);
    return SizedBox(
      width: double.infinity,
      child: RotatedBox(
        quarterTurns: -3,
        child: ToggleButtons(
          selectedColor: Colors.white,
          fillColor: Colors.blue,
          children: [
            DayNo(
              no: '1',
            ),
            DayNo(
              no: '2',
            ),
            DayNo(
              no: '3',
            ),
            DayNo(
              no: '4',
            ),
            DayNo(
              no: '5',
            ),
            DayNo(
              no: '6',
            ),
            DayNo(
              no: '7',
            ),
          ],
          isSelected: isSelected,
          onPressed: (index) {
            setState(() {
              for (int buttonIndex = 0;
                  buttonIndex < isSelected.length;
                  buttonIndex++) {
                if (buttonIndex == index) {
                  isSelected[buttonIndex] = !isSelected[buttonIndex];
                } else {
                  isSelected[buttonIndex] = false;
                }
                DayScreen().dayNo = (index + 1).toString();
              }
            });
          },
        ),
      ),

      //  MaterialButton(
      //   color: Color(0xffF7F7F7),
      //   minWidth: 0,
      //   padding: EdgeInsets.all(0),
      //   onPressed: () {
      //     widget.numberChosen();
      //   },
      //   child: Padding(
      //     padding: const EdgeInsets.only(top: 14),
      //     child: Text(
      //       widget.no,
      //       style: TextStyle(
      //           color: widget.mycolor, fontFamily: 'mija', fontSize: 15),
      //     ),
      //   ),
      // ),
    );
  }
}

class DayNo extends StatelessWidget {
  final String no;
  DayNo({this.no});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 14.0, 0.0, 9.0),
        child: RotatedBox(
          quarterTurns: -1,
          child: Text(
            '$no',
            style: TextStyle(
                color: Colors.black, fontFamily: 'mija', fontSize: 15),
          ),
        ));
  }
}

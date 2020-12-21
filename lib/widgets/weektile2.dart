import 'package:flutter/material.dart';
import 'package:get_active_prf/screens/DayScreen.dart';
import 'package:get_active_prf/screens/jussst.dart';
import 'package:get_active_prf/services/cloud_data.dart';
import 'package:page_transition/page_transition.dart';

class WeekTile2 extends StatelessWidget {
  final String no;
  WeekTile2({this.no});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 9),
          child: Container(
            width: MediaQuery.of(context).size.width - 88,
            decoration: BoxDecoration(
              color: Color(0xfff0a500),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 9),
          child: GestureDetector(
            onPanUpdate: (details) {
              if (details.delta.dy < 0) {
                Stream mystream = CloudData().getweeksstream(no);
                Navigator.push(
                    context,
                    PageTransition(
                        child: DayScreen(
                          week: mystream,
                        ),
                        type: PageTransitionType.downToUp));
              }
            },
            child: Container(
              width: MediaQuery.of(context).size.width - 88,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0)),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 21.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        '0$no',
                        style: TextStyle(
                          fontSize: 46,
                          fontFamily: 'mija',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

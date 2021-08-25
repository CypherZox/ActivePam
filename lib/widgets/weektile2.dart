import 'package:flutter/material.dart';
import 'package:get_active_prf/screens/DayScreen.dart';
import 'package:get_active_prf/services/cloud_data.dart';
import 'package:page_transition/page_transition.dart';

//ignore: must_be_immutable
class WeekTile2 extends StatelessWidget {
  final String no;
  final List flags;
  final int index;
  final int weekprctng;
  String dayNo;
  WeekTile2({this.no, this.flags, this.index, this.dayNo, this.weekprctng});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 9),
          child: Container(
            width: MediaQuery.of(context).size.width - 88,
            decoration: BoxDecoration(
              color: flags[index]
                  ? Color(0xfff0a500).withOpacity(0.6)
                  : Color(0xfff0a500),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 9),
          child: GestureDetector(
            onPanUpdate: (details) async {
              if (details.delta.dy < 0) {
                print('week on tile is $no');
                print('week on tile is $dayNo');
                Stream mystream = CloudData().getweeksstream(no);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DayScreen(
                            week: mystream, weekNo: no, dayNo: dayNo)));
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
                    SizedBox(
                      height: 2,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        '${weekprctng.toString()}%',
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'mija',
                            color: Colors.black45),
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

import 'package:flutter/material.dart';
import 'package:get_active_prf/models/data_models/video.dart';
import 'package:get_active_prf/screens/vid_screen.dart';
import 'package:get_active_prf/services/database_service.dart';
import 'package:get_active_prf/widgets/DayNumber.dart';
import 'package:get_active_prf/widgets/days_view.dart';
import 'package:get_active_prf/widgets/start_button.dart';

class TestScreen extends StatefulWidget {
  final String weekNo;
  final String version;
  TestScreen({this.weekNo, this.version});
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  String dayNo = '1';
  int prcntg;
  List<String> ids;
  DatabaseService databaseService = DatabaseService();
  // make a stream provider with the stream of the doc snapshot

  final pageController = PageController(initialPage: 0, keepPage: true);
  final navItems = [
    DayNumber(no: '1'),
    DayNumber(no: '2'),
    DayNumber(no: '3'),
    DayNumber(no: '4'),
    DayNumber(no: '5'),
    DayNumber(no: '6'),
    DayNumber(no: '7'),
  ];
  final initialTab = 0;
  onNumberTapped(value) {
    setState(() {
      dayNo = value;
    });
    print('$dayNo');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder(
          stream: databaseService.myStreem,
          builder: (context, snapshot) {
            return Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height - 150,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 96.0, 0.0, 0.0),
                        child: Column(
                          children: [
                            DayNumber(
                              no: '1',
                              numberChosen: () {
                                setState(() {
                                  dayNo = '1';
                                  prcntg = snapshot.data
                                      .data()['week${this.widget.weekNo}'][0];
                                });
                              },
                            ),
                            DayNumber(
                              no: '2',
                              numberChosen: () {
                                setState(() {
                                  dayNo = '2';
                                  prcntg = snapshot.data
                                      .data()['week${this.widget.weekNo}'][2];
                                });
                              },
                            ),
                            DayNumber(
                              no: '3',
                              numberChosen: () {
                                setState(() {
                                  dayNo = '3';
                                  prcntg = snapshot.data
                                      .data()['week${this.widget.weekNo}'][2];
                                });
                              },
                            ),
                            // DayNumber(no: '4', numberChosen: onNumberTapped('4')),
                            DayNumber(
                              no: '5',
                              numberChosen: () {
                                setState(() {
                                  dayNo = '5';
                                  prcntg = snapshot.data
                                      .data()['week${this.widget.weekNo}'][3];
                                });
                              },
                            ),
                            DayNumber(
                              no: '6',
                              numberChosen: () {
                                setState(() {
                                  dayNo = '6';
                                  prcntg = snapshot.data
                                      .data()['week${this.widget.weekNo}'][4];
                                });
                              },
                            ),
                            // DayNumber(no: '7', numberChosen: onNumberTapped('7')),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 44,
                      ),
                      SizedBox(
                        height: 170,
                      ),
                      Expanded(
                          child: FutureBuilder<List<dynamic>>(
                        future: VideoModel().getIDs(this.dayNo,
                            this.widget.weekNo, this.widget.version),
                        builder: (context, snapshot) {
                          return snapshot.hasData
                              ? DaysList(
                                  vidIds: snapshot.data,
                                  // prcntg: prcntg,
                                  // prcntg: Provider.of<DataService>(context).getUserProgress(this.widget.dayNo
                                  // this.widget.weekNo)
                                )
                              : Center(child: CircularProgressIndicator());
                        },
                      )),
                    ],
                  ),
                ),
                StartButton(onpressed: () {
                  VideoModel()
                      .getIDs(
                          this.dayNo, this.widget.weekNo, this.widget.version)
                      .then((value) {
                    print(value);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VidScreen(
                                  ids: value,
                                  weekNo: this.widget.weekNo,
                                  version: this.widget.version,
                                  dayNo: this.dayNo,
                                )));
                  });
                  Navigator.pushNamed(context, '/VidScreen');
                })
              ],
            );
          }),
    );
  }
}

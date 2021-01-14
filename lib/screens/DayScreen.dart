import 'package:flutter/material.dart';
import 'package:get_active_prf/custom_icons/rarow_icons.dart';
import 'package:get_active_prf/screens/explore.dart';
import 'package:get_active_prf/screens/jussst.dart';
import 'package:get_active_prf/screens/vid_screen.dart';
import 'package:get_active_prf/services/cloud_data.dart';
import 'package:get_active_prf/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:page_transition/page_transition.dart';
import 'package:get_active_prf/widgets/DayNumber.dart';

class DayScreen extends StatefulWidget {
  final Stream week;
  final String weekNo;
  String dayNo;
  DayScreen({this.week, this.weekNo, this.dayNo});
  @override
  _DayScreenState createState() => _DayScreenState();
}

class _DayScreenState extends State<DayScreen> {
  final PageController ctrl = PageController(viewportFraction: 0.8);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // String dayNo = this.dayNo;
  int prcntg;
  int currentPage = 0;
  User get user {
    return _auth.currentUser;
  }

  final navItems = [
    DayNumber(no: '1'),
    DayNumber(no: '2'),
    DayNumber(no: '3'),
    DayNumber(no: '4'),
    DayNumber(no: '5'),
    DayNumber(no: '6'),
    DayNumber(no: '7'),
  ];

  @override
  void dispose() {
    super.dispose();
  }

  void initState() {
    super.initState();

    // Set state when page changes
    ctrl.addListener(() {
      int next = ctrl.page.round();

      if (currentPage != next) {
        setState(() {
          currentPage = next;
        });
      }
    });
  }

  CloudData cloudData = CloudData();
  DatabaseService databaseService = DatabaseService();
  // final week = CloudData().vidIds.doc('week1').snapshots();
  @override
  Widget build(BuildContext context) {
    List<bool> _list = [false, false, false, false, false, false, false];
    return GestureDetector(
      onPanUpdate: (details) {
        if (details.delta.dx > 0) {
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.pushReplacement(
              context,
              PageTransition(
                  duration: Duration(milliseconds: 150),
                  child: Explore(),
                  type: PageTransitionType.leftToRight));
        }
      },
      child: Scaffold(
        backgroundColor: Color(0xffF7F7F7),
        body: StreamBuilder(
            stream: this.widget.week,
            builder: (context, AsyncSnapshot snap) {
              if (snap.hasError) {
                return Text('Something went wrong');
              }
              if (snap.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }

              final vids = snap.data.data()['day${this.widget.dayNo}'];

              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color(0xffF7F7F7).withOpacity(0.7),
                                border: Border(
                                    right: BorderSide(
                                        width: 0.7, color: Colors.black))),
                            width: 60,
                            child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    0.0, 90, 0.0, 0.0),
                                child: Column(
                                  children: [
                                    RotatedBox(
                                      quarterTurns: -3,
                                      child: ToggleButtons(
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
                                        isSelected: _list,
                                        onPressed: (index) {
                                          setState(() {
                                            for (int indexBtn = 0;
                                                indexBtn < _list.length;
                                                indexBtn++) {
                                              if (indexBtn == index) {
                                                _list[indexBtn] =
                                                    !_list[indexBtn];
                                              } else {
                                                _list[indexBtn] = false;
                                              }
                                            }
                                            setState(() {
                                              this.widget.dayNo =
                                                  '${index + 1}';
                                            });
                                          });
                                        },
                                        selectedColor: Color(0xfff0a500),
                                        fillColor: Colors.amber,
                                      ),
                                    ),
                                  ],
                                )
                                // child: ListView.builder(
                                //     itemCount: 7,
                                //     scrollDirection: Axis.vertical,
                                //     itemBuilder: (context, index) {
                                //       final no = days[index];
                                //       Color mycolor = colors[index];

                                //       return DayNumber(
                                //         mycolor: _list[index]
                                //             ? Color(0xfff0a500).withOpacity(0.4)
                                //             : Colors.black,
                                //         no: no,
                                //         numberChosen: () {
                                //           setState(() {
                                //             _list[index] = !_list[index];
                                //             this.widget.dayNo = no;
                                //             print(_list);
                                //             // prcntg = snap.data.data()['week1'][2];
                                //           });
                                //         },
                                //       );
                                //     })
                                // child: Column(
                                //   children: [
                                //     DayNumber(
                                //       no: '1',
                                //       numberChosen: () {
                                //         setState(() {
                                //           this.widget.dayNo = '1';
                                //           // prcntg = snap.data.data()['week1'][0];
                                //         });
                                //       },
                                //     ),
                                //     DayNumber(
                                //       no: '2',
                                //       numberChosen: () {
                                //         setState(() {
                                //           this.widget.dayNo = '2';
                                //           // prcntg = snap.data.data()['week1'][2];
                                //         });
                                //       },
                                //     ),
                                //     DayNumber(
                                //       no: '3',
                                //       numberChosen: () {
                                //         setState(() {
                                //           this.widget.dayNo = '3';
                                //           // prcntg = snap.data.data()['week1'][2];
                                //         });
                                //       },
                                //     ),

                                //     DayNumber(
                                //       no: '4',
                                //       numberChosen: () {
                                //         setState(() {
                                //           this.widget.dayNo = '4';
                                //           // prcntg = snap.data.data()['week1'][2];
                                //         });
                                //       },
                                //     ),
                                //     // DayNumber(no: '4', numberChosen: onNumberTapped('4')),
                                //     DayNumber(
                                //       no: '5',
                                //       numberChosen: () {
                                //         setState(() {
                                //           this.widget.dayNo = '5';
                                //           // prcntg = snap.data.data()['week1'][3];
                                //         });
                                //       },
                                //     ),
                                //     DayNumber(
                                //       no: '6',
                                //       numberChosen: () {
                                //         setState(() {
                                //           this.widget.dayNo = '6';
                                //           // prcntg = snap.data.data()['week1'][4];
                                //         });
                                //       },
                                //     ),
                                //     DayNumber(
                                //       no: '7',
                                //       numberChosen: () {
                                //         setState(() {
                                //           this.widget.dayNo = '7';
                                //           // prcntg = snap.data.data()['week1'][2];
                                //         });
                                //       },
                                //     ),
                                //     //
                                //   ],
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: PageView.builder(
                        controller: ctrl,
                        itemCount: vids.length,
                        itemBuilder: (context, int currentIdx) {
                          // Active page
                          bool active = currentIdx == currentPage;
                          return _buildStoryPage(vids[currentIdx], active,
                              context, this.widget.dayNo, this.widget.weekNo);
                        }),
                  ),
                ],
              );
            }),
      ),
    );
    //   ),
    // );
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

_buildStoryPage(
    Map data, bool active, BuildContext context, String dayNo, String weekNo) {
  // Animated Properties
  final double top = active ? 30 : 80;
  final String title = data['title'];
  final String version = data['version'];
  final List vids = data['vids'];

  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(11.0, 50, 0.0, 0.0),
        child: Align(
          alignment: Alignment.topLeft,
          child: version != null
              ? Text(
                  '$version',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 27,
                      fontFamily: 'mija',
                      color: Colors.black),
                )
              : Text(" "),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(11.0, 2.0, 0.0, 0.0),
        child: Align(
            alignment: Alignment.topLeft,
            child: title != 'Rest Day'
                ? Text(
                    '$title',
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 20,
                        fontFamily: 'mija',
                        color: Colors.black.withOpacity(0.4)),
                  )
                : Text(
                    'Rest Day',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 30,
                        fontFamily: 'mija',
                        color: Colors.black),
                  )),
      ),
      Expanded(
        flex: 4,
        child: Align(
          alignment: Alignment.topLeft,
          child: AnimatedContainer(
            width: 190,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeOutQuint,
            margin: EdgeInsets.only(top: top, bottom: 0, left: 11),
            child: (vids.length > 0) ? Jusst(vidIds: vids) : Container(),
          ),
        ),
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(130, 0, 0, 9),
          child: (vids.length > 0)
              ? IconButton(
                  alignment: Alignment.bottomLeft,
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.upToDown,
                            child: VidScreen(
                              ids: vids,
                              dayNo: dayNo,
                              weekNo: weekNo,
                              version: version,
                            )));
                  },
                  icon: Icon(
                    Rarow.right_arrow__1_,
                    size: 26,
                  ))
              : Container(),
        ),
      ),
    ],
  );
}

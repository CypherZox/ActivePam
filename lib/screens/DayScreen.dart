import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get_active_prf/screens/jussst.dart';
import 'package:get_active_prf/screens/vid_screen.dart';
import 'package:get_active_prf/services/cloud_data.dart';
import 'package:get_active_prf/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:page_transition/page_transition.dart';
import 'package:get_active_prf/custom_icons/forwared_arrow_icons.dart';
import 'package:get_active_prf/widgets/DayNumber.dart';

class DayScreen extends StatefulWidget {
  final Stream week;
  DayScreen({this.week});
  @override
  _DayScreenState createState() => _DayScreenState();
}

class _DayScreenState extends State<DayScreen> {
  final PageController ctrl = PageController(viewportFraction: 0.8);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String dayNo = '1';
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
    return Scaffold(
      backgroundColor: Color(0xffe1d4e5),
      body: StreamBuilder(
          stream: this.widget.week,
          builder: (context, AsyncSnapshot snap) {
            if (snap.hasError) {
              return Text('Something went wrong');
            }
            if (snap.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }
            final vids = snap.data.data()['day${this.dayNo}'];
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
                          width: 40,
                          color: Color(0xffCABECE),
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(0.0, 90, 0.0, 0.0),
                            child: Column(
                              children: [
                                DayNumber(
                                  no: '1',
                                  numberChosen: () {
                                    setState(() {
                                      dayNo = '1';
                                      // prcntg = snap.data.data()['week1'][0];
                                    });
                                  },
                                ),
                                DayNumber(
                                  no: '2',
                                  numberChosen: () {
                                    setState(() {
                                      dayNo = '2';
                                      // prcntg = snap.data.data()['week1'][2];
                                    });
                                  },
                                ),
                                DayNumber(
                                  no: '3',
                                  numberChosen: () {
                                    setState(() {
                                      dayNo = '3';
                                      // prcntg = snap.data.data()['week1'][2];
                                    });
                                  },
                                ),
                                // DayNumber(no: '4', numberChosen: onNumberTapped('4')),
                                DayNumber(
                                  no: '5',
                                  numberChosen: () {
                                    setState(() {
                                      dayNo = '5';
                                      // prcntg = snap.data.data()['week1'][3];
                                    });
                                  },
                                ),
                                DayNumber(
                                  no: '6',
                                  numberChosen: () {
                                    setState(() {
                                      dayNo = '6';
                                      // prcntg = snap.data.data()['week1'][4];
                                    });
                                  },
                                ),
                                //
                              ],
                            ),
                          ),
                        ),
                      )
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
                        return _buildStoryPage(
                            vids[currentIdx], active, context);
                      }),
                ),
              ],
            );
          }),
    );
    //   ),
    // );
  }
}

_buildStoryPage(Map data, bool active, BuildContext context) {
  // Animated Properties
  final double blur = active ? 2 : 0;
  final double offset = active ? 0 : 0;
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
          child: Text(
            '$version',
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 27,
                fontFamily: 'mija',
                color: Colors.black),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(11.0, 2.0, 0.0, 0.0),
        child: Align(
            alignment: Alignment.topLeft,
            child: title != null
                ? Text(
                    '$title',
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 20,
                        fontFamily: 'mija',
                        color: Colors.black.withOpacity(0.4)),
                  )
                : Text('')),
      ),
      Expanded(
        flex: 4,
        child: Align(
          alignment: Alignment.topLeft,
          child: AnimatedContainer(
            width: 200,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeOutQuint,
            margin: EdgeInsets.only(top: top, bottom: 0, left: 11),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              //  boxShadow: [
              //   BoxShadow(
              //       color: Colors.black87,
              //       blurRadius: blur,
              //       offset: Offset(offset, offset))
              // ]
            ),
            child: Jusst(vidIds: vids),
          ),
        ),
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(90, 0, 0, 9),
          child: IconButton(
              alignment: Alignment.bottomLeft,
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.upToDown,
                        child: VidScreen(
                          ids: vids,
                          dayNo: '1',
                          weekNo: '1',
                          version: version,
                        )));
              },
              icon: Icon(
                ForwaredArrow.right_arrow,
                size: 26,
              )),
        ),
      ),
    ],
  );
}

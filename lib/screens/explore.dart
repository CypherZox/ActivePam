import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_active_prf/data/percentage_logic.dart';
import 'package:get_active_prf/models/day_vid_list.dart';
import 'package:get_active_prf/models/weeks_list.dart';
import 'package:get_active_prf/screens/log_in.dart';
import 'package:get_active_prf/services/auth.dart';
import 'package:get_active_prf/services/cloud_data.dart';
import 'package:get_active_prf/services/database_service.dart';
import 'package:get_active_prf/widgets/weektile2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:page_transition/page_transition.dart';
import 'package:get_active_prf/custom_icons/options_icons.dart';

class Explore extends StatefulWidget {
  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User get user {
    return _auth.currentUser;
  }

  CloudData cloudData = CloudData();
  final weeksstream = CloudData().weeksno.doc('no_of_weeks').snapshots();
  final CollectionReference progCollection =
      FirebaseFirestore.instance.collection('userprogress');
  String get name {
    return user.displayName;
  }

  AuthService auth = AuthService();
  DayVidList _dayVidList = DayVidList();
  String getusername() {
    var user = _auth.currentUser;
    String name = user.displayName;
    return name;
  }

  int currentweek1 = 1;
  void currentWeek() async {
    int current = await DatabaseService().getcurrentweek();
    setState(() {
      currentweek1 = current;
    });
  }

  int currentday1 = 1;
  void currentDay() async {
    int current = await DatabaseService().getcurrentday();
    setState(() {
      currentday1 = current;
    });
  }

  void initstate() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      endDrawer: Drawer(
        child: Container(
          color: Color(0xffF7F7F7),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 21.0, 0.0),
                child: SizedBox(
                  height: height - 30,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            await AuthService().signOut();
                            Navigator.pushReplacement(
                                context,
                                PageTransition(
                                    duration: Duration(milliseconds: 250),
                                    child: LogIn(),
                                    type: PageTransitionType
                                        .rightToLeftWithFade));
                          },
                          child: Text(
                            'Log Out',
                            style: TextStyle(
                                fontSize: 36,
                                fontFamily: 'mija',
                                color: Colors.black),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          child: Text(
                            'Info',
                            style: TextStyle(
                                fontSize: 36,
                                fontFamily: 'mija',
                                color: Colors.black),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      backgroundColor: Color(0xfff4f4f4),
      body: Builder(
        builder: (context) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 0.0),
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(
                      Options.show_more_button_with_three_dots,
                      size: 18,
                    ),
                    onPressed: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                  ),
                ),
                // Align(
                //   alignment: Alignment.topRight,
                //   child: GestureDetector(
                //     onTap: () {
                //       auth.signOut();
                //       Navigator.push(
                //           context,
                //           PageTransition(
                //               child: LogIn(), type: PageTransitionType.upToDown));
                //     },
                //     child: Text(
                //       'Log out',
                //       style: TextStyle(
                //           fontSize: 20,
                //           fontFamily: 'mija',
                //           color: Colors.black.withOpacity(0.4)),
                //     ),

                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 30, 0.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Welcome,\n$name',
                          style: TextStyle(fontSize: 46, fontFamily: 'mija'),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Start your workout now',
                          style: TextStyle(
                              fontSize: 36,
                              fontFamily: 'mija',
                              color: Colors.black.withOpacity(0.3)),
                        ),
                      ),
                      SizedBox(
                        height: 120.0,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: StreamBuilder(
                      stream: weeksstream,
                      builder: (context, AsyncSnapshot snap) {
                        currentWeek();
                        currentDay();
                        if (snap.hasError) {
                          return Text('Something went wrong');
                        }
                        if (snap.connectionState == ConnectionState.waiting) {
                          return Text("Loading");
                        }
                        final noofweeks = snap.data.data()['no_of_weeks'];
                        // final weeky = snap.data['no_of_weeks'];
                        // int currentweek = currentWeek();

                        // int currentweek = currentweek1;
                        List vids =
                            _dayVidList.getvids(noofweeks, currentweek1);
                        List flags =
                            _dayVidList.flagvids(noofweeks, currentweek1);
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final no = vids[index];
                            return WeekTile2(
                              dayNo: currentday1.toString(),
                              no: no.toString(),
                              flags: flags,
                              index: index,
                            );
                          },
                          itemCount: vids.length,
                        );
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

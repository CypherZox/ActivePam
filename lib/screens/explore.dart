import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_active_prf/models/day_vid_list.dart';
import 'package:get_active_prf/models/progress.dart';
import 'package:get_active_prf/screens/log_in.dart';
import 'package:get_active_prf/services/auth.dart';
import 'package:get_active_prf/services/database_service.dart';
import 'package:get_active_prf/services/setalarm.dart';
import 'package:get_active_prf/widgets/weektile2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_active_prf/custom_icons/options_icons.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class Explore extends StatefulWidget {
  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  DateTime _alarmTime;
  String _alarmTimeString;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User get user {
    return _auth.currentUser;
  }

  final CollectionReference progCollection =
      FirebaseFirestore.instance.collection('userprogress');
  get name {
    if (mounted) {
      return user.displayName;
    }
  }

  AuthService auth = AuthService();
  DayVidList _dayVidList = DayVidList();

  void initstate() {
    _alarmTime = DateTime.now();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  DatabaseService db = DatabaseService();
  @override
  Widget build(BuildContext context) {
    UserProgress userProgress = UserProgress();
    UserProgress userpog = Provider.of<UserProgress>(context, listen: true);
    final int noofweeks = Provider.of<int>(context) ?? 1;
    int _currentDay = userpog?.currentDay ?? userProgress.getcurrentDay();
    int _currentWeek = userpog?.currentWeek ?? 1;
    int progressprcnt =
        userpog?.progressPrcntge ?? userProgress.getprogressPrcntge();

    List vids = _dayVidList.getvids(noofweeks, _currentWeek);
    List prcntg =
        _dayVidList.weekprcntg(noofweeks, _currentWeek, progressprcnt);
    List flags = _dayVidList.flagvids(noofweeks, _currentWeek);
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      endDrawer: SideDrawer(
        height: height,
        alarmTime: _alarmTime,
        alarmTimeString: _alarmTimeString,
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
                    child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final no = vids[index];
                    final mprcntg = prcntg[index];
                    return WeekTile2(
                      weekprctng: mprcntg,
                      dayNo: _currentDay.toString(),
                      no: no.toString(),
                      flags: flags,
                      index: index,
                    );
                  },
                  itemCount: vids.length,
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//ignore: must_be_immutable
class SideDrawer extends StatefulWidget {
  DateTime alarmTime;
  String alarmTimeString;
  final double height;
  SideDrawer({this.height, this.alarmTime, this.alarmTimeString});

  @override
  _SideDrawerState createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      //options drawer (info, logout, adding reminders)
      child: Container(
        color: Color(0xffF7F7F7),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 21.0, 0.0),
              child: SizedBox(
                height: widget.height - 30,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: Colors.transparent,
                                    title: Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          0.0, 200, 0.0, 0.0),
                                      child: Center(
                                        child: Text(
                                          'Add reminders',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 22,
                                              fontFamily: 'mija',
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                    content: Stack(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0.0, 0.0, 0.0, 5.0),
                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              'Choose prefered timing for your daily workouts remaiders',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w100,
                                                  fontSize: 15,
                                                  fontFamily: 'mija',
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              35.0, 60.0, 0.0, 0.0),
                                          child: MaterialButton(
                                            child: Text(
                                              'Select time',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w100,
                                                  fontSize: 19,
                                                  fontFamily: 'mija',
                                                  color: Colors.black),
                                            ),
                                            onPressed: () async {
                                              var selectedTime =
                                                  await showTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay.now(),
                                              );
                                              if (selectedTime != null) {
                                                final now = DateTime.now();
                                                var selectedDateTime = DateTime(
                                                    now.year,
                                                    now.month,
                                                    now.day,
                                                    selectedTime.hour,
                                                    selectedTime.minute);
                                                this.widget.alarmTime =
                                                    selectedDateTime;
                                                setState(() {
                                                  this.widget.alarmTimeString =
                                                      DateFormat('HH:mm')
                                                          .format(
                                                              selectedDateTime);
                                                });
                                              }
                                            },
                                            color: Color(0xfff0a500),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              15.0, 150.0, 0.0, 0.0),
                                          child: Row(
                                            children: [
                                              Container(
                                                child: MaterialButton(
                                                    child: Text(
                                                      'Cancel',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          fontSize: 17,
                                                          fontFamily: 'mija',
                                                          color: Colors.black),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    }),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                    border: Border(
                                                        left: BorderSide(
                                                            width: 4.0,
                                                            color:
                                                                Colors.black))),
                                                child: MaterialButton(
                                                  child: Text(
                                                    'Ok',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        fontSize: 17,
                                                        fontFamily: 'mija',
                                                        color: Colors.black),
                                                  ),
                                                  onPressed: () async {
                                                    //function to add schedueled alarms
                                                    onSaveAlarm();
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                });
                          }
                        },
                        child: Text(
                          'Reminders',
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
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () async {
                          await AuthService().signOut();

                          Navigator.pushAndRemoveUntil(
                              context,
                              PageRouteBuilder(pageBuilder:
                                  (BuildContext context, Animation animation,
                                      Animation secondaryAnimation) {
                                return LogIn();
                              }, transitionsBuilder: (BuildContext context,
                                  Animation<double> animation,
                                  Animation<double> secondaryAnimation,
                                  Widget child) {
                                return new SlideTransition(
                                  position: new Tween<Offset>(
                                    begin: const Offset(1.0, 0.0),
                                    end: Offset.zero,
                                  ).animate(animation),
                                  child: child,
                                );
                              }),
                              (Route route) => false);
                        },
                        child: Text(
                          'Log Out',
                          style: TextStyle(
                              fontSize: 34,
                              fontFamily: 'mija',
                              color: Colors.black.withOpacity(0.7)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

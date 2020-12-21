import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_active_prf/models/weeks_list.dart';
import 'package:get_active_prf/screens/log_in.dart';
import 'package:get_active_prf/services/auth.dart';
import 'package:get_active_prf/services/cloud_data.dart';
import 'package:get_active_prf/services/database_service.dart';
import 'package:get_active_prf/widgets/weektile2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:page_transition/page_transition.dart';

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

  String getusername() {
    var user = _auth.currentUser;
    String name = user.displayName;
    return name;
  }

  void initstate() {
    super.initState();
    // setState(() {
    //   this.name = getusername();
    // });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff4f4f4),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 0.0),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              MaterialButton(
                onPressed: () {
                  print(user.uid);
                  DatabaseService(uid: '${user.uid}').chngdata('week5', 1, 23);

                  // progCollection.doc('${user.uid}').set({
                  //   'week1': [0, 0, 0, 0, 0, 0, 0],
                  // });
                  // progCollection.doc('${user.uid}').update({
                  //   'week2': [0, 9, 0, 0, 0, 0],
                  // });
                  // List tel = [0, 0, 0, 0, 0, 0];
                  // progCollection.doc('${user.uid}').get().then((value) {
                  //   {
                  //     if (value.data()['week4'] != null) {
                  //       tel = value.data()['week4'];
                  //       print(tel);
                  //     }
                  //     progCollection.doc('${user.uid}').update({
                  //       'week4': [0, 9, 0, 0, 0, 0],
                  //     });
                  //   }
                  // });
                },
                color: Colors.black,
              ),
              MaterialButton(
                onPressed: () {
                  auth.signOut();
                  Navigator.push(
                      context,
                      PageTransition(
                          child: LogIn(), type: PageTransitionType.upToDown));
                },
                color: Colors.black,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 90, 0.0, 0.0),
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
                      if (snap.hasError) {
                        return Text('Something went wrong');
                      }
                      if (snap.connectionState == ConnectionState.waiting) {
                        return Text("Loading");
                      }
                      final noofweeks = snap.data.data()['no_of_weeks'];
                      // final weeky = snap.data['no_of_weeks'];
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          // final week = WeeksList().weeks[index];
                          final no = index;
                          return WeekTile2(
                            no: '${no + 1}',
                          );
                        },
                        itemCount: noofweeks,
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

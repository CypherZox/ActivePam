import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_active_prf/models/data_models/video.dart';
import 'package:get_active_prf/widgets/days_view.dart';
import 'package:get_active_prf/services/database_service.dart';

class JustAtest extends StatefulWidget {
  final String weekNo;
  final String version;
  JustAtest({this.weekNo, this.version});
  @override
  _JustAtestState createState() => _JustAtestState();
}

class _JustAtestState extends State<JustAtest> {
  final String dayNo = '1';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User get user {
    return _auth.currentUser;
  }

  String get name {
    return user.displayName;
  }
  //   User get user {
  //     return _auth.currentUser;
  //   }

  // String get name {
  //   return user.displayName;}
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
        body: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              color: Color(0xffdbdbdb),
              width: 40,
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(22.0, 60.0, 22.0, 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        '01',
                        style: TextStyle(fontFamily: 'mija', fontSize: 46),
                      ),
                    ),
                    SizedBox(
                      height: 1.0,
                    ),
                    MaterialButton(onPressed: () {
                      DatabaseService().updatecurrentday();
                    }),
                    Expanded(
                        child: FutureBuilder<List<dynamic>>(
                      future: VideoModel().getIDs('1', '1', 'beginner'),
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
            )
          ],
        ));
  }
}

class LRbutton extends StatelessWidget {
  final Function onpressedfunc;
  final String title;
  LRbutton({this.onpressedfunc, this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(boxShadow: <BoxShadow>[
          BoxShadow(
              offset: Offset(6, 9),
              color: Colors.grey.withOpacity(0.9),
              spreadRadius: 5.0,
              blurRadius: 14.0),
        ], borderRadius: BorderRadius.circular(40)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: RaisedButton(
            color: Color(0xff000000),
            child: Center(
              child: Text(
                '$title',
                style: TextStyle(
                  fontFamily: 'mija',
                  color: Color(0xfff4f4f4),
                ),
              ),
            ),
            onPressed: onpressedfunc,
          ),
        ),
      ),
    );
  }
}

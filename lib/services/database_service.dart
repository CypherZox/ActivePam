import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_active_prf/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  // final String uid;
  // DatabaseService({this.uid});

  // collection reference
  final FirebaseAuth auth = FirebaseAuth.instance;
  User get user {
    return auth.currentUser;
  }

  String get uid {
    return user.uid;
  }

  final CollectionReference progCollection =
      FirebaseFirestore.instance.collection('userprogress');
  DocumentSnapshot snapshot;
  void getmyData() async {
    //use a Async-await function to get the data
    final data = await progCollection.doc(uid).get(); //get the data
    snapshot = data;
  }

  Future<List> getData(String week) async {
    List weeky = await progCollection.doc(uid).get().then((value) {
      {
        if (value.data()['$week'] != null) {
          return value.data()['$week'];
        }
      }
    });
    return weeky;
  }

  Future<int> getcurrentweek() async {
    int currentweek = await progCollection.doc(uid).get().then((value) {
      return value.data()['current_week'];
    });
    return currentweek;
  }

  Future<int> getcurrentday() async {
    int currentday = await progCollection.doc(uid).get().then((value) {
      return value.data()['current_day'];
    });
    return currentday;
  }

  Future<List> chngdata(String week, int dayNo, int prcntg) async {
    List toEditList = [0, 0, 0, 0, 0, 0];
    List currentWeek = await getData(week);
    if (currentWeek != null) {
      toEditList = currentWeek;
    }
    toEditList[dayNo] = prcntg;
    // print(toEditList);
    progCollection.doc(uid).update({
      '$week': toEditList,
    });
    return getData(week);
  }

  void updatecurrentweek() async {
    int current = await getcurrentweek();
    progCollection.doc(uid).update({
      'current_week': (current + 1),
    });
  }

  void updatecurrentday() async {
    int current = await getcurrentday();
    progCollection.doc(uid).update({
      'current_day': (current + 1) % 7,
    });
  }

  Stream get myStreem {
    return progCollection.doc(uid).snapshots();
  }
}

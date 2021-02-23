import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_active_prf/models/progress.dart';
import 'package:get_active_prf/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class DatabaseService {
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
  Stream<UserProgress> getUerProgress(String id) {
    return progCollection
        .doc(id)
        .snapshots()
        .map((snap) => UserProgress.fromMap(snap.data()));
  }

  Stream<int> setnoofweeks(String id) {
    return FirebaseFirestore.instance
        .collection('no_of_weeks')
        .doc('no_of_weeks')
        .snapshots()
        .map((snap) => snap.data()['no_of_weeks']);
  }

  Future<DocumentSnapshot> getmyData() async {
    //use a Async-await function to get the data
    final data = await progCollection.doc(uid).get(); //get the data
    snapshot = data;
    return data;
  }

  Future<List> getData(String week) async {
    List weeky = await getmyData().then((value) {
      {
        if (value.data()['$week'] != null) {
          return value.data()['$week'];
        }
      }
    });
    return weeky;
  }

  Future<int> getcurrentweek() async {
    int currentweek = await getmyData().then((value) {
      return value.data()['current_week'];
    });
    return currentweek;
  }

  Future<int> getcurrentday() async {
    int currentday = await getmyData().then((value) {
      return value.data()['current_day'];
    });
    return currentday;
  }

  Future<int> getweekprctng() async {
    int weekprctng = await getmyData().then((value) {
      return value.data()['weekprctng'];
    });
    return weekprctng;
  }

  Future<List> chngdata(String week, int dayNo, int prcntg) async {
    List toEditList = [0, 0, 0, 0, 0];
    print('day no is' + dayNo.toString());
    List currentWeek = await getData(week);
    if (currentWeek != null) {
      toEditList = currentWeek;
    }
    if (prcntg <= 100 && prcntg >= 0) {
      if (prcntg >= toEditList[dayNo]) {
        print(prcntg);
        toEditList[dayNo] = prcntg;
      }
      // } else if (prcntg < toEditList[dayNo]) {
      //   print(prcntg);
      //   toEditList[dayNo] = toEditList[dayNo];
      // }
    } else {
      print(prcntg);
      toEditList[dayNo] = 100;
    }
    // print(toEditList);
    progCollection.doc(uid).update({
      '$week': toEditList,
    });

    return getData(week);
  }

  void updateweekprcntg(int weekprctng) async {
    int currentweekprcntge = await getcurrentweek();
    if (weekprctng != null) {
      if (weekprctng > currentweekprcntge) {
        progCollection.doc(uid).update({
          'weekprctng': weekprctng,
        });
      }
    }
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
      'current_day': (current % 5) + 1,
    });
  }

  Stream get myStreem {
    return progCollection.doc(uid).snapshots();
  }
}

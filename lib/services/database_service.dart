import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_active_prf/models/progress.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  User get user {
    return auth.currentUser;
  }

  String get uid {
    return user?.uid;
  }

  final CollectionReference progCollection =
      FirebaseFirestore.instance.collection('userprogress');
  DocumentSnapshot snapshot;
  Stream<UserProgress> getUerProgress() {
    return progCollection
        .doc(uid)
        .snapshots()
        .map((snap) => UserProgress.fromMap(snap.data()));
  }

  Stream<int> setnoofweeks() {
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
    if (dayNo != 3 || dayNo != 7) {
      if (3 < dayNo && dayNo < 6) {
        dayNo -= 1;
      }
      if (dayNo == 6) {
        dayNo = 4;
      }
      if (prcntg <= 100 && prcntg >= 0) {
        if (prcntg >= toEditList[dayNo]) {
          print(prcntg);
          toEditList[dayNo] = prcntg;
        }
      } else {
        print(prcntg);
        toEditList[dayNo] = 100;
      }
      // print(toEditList);
      progCollection.doc(uid).update({
        '$week': toEditList,
      });
      print('infunc prcntg' + toEditList.toString());
    }

    return toEditList;
  }

  void updateweekprcntg(int weekprctng) async {
    print('upp');
    int currentweekprcntge = await getcurrentweek();
    print('current week prcntg' + currentweekprcntge.toString());
    if (weekprctng != null) {
      print('stage1');
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

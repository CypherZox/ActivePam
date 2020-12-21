import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  // Map<dynamic, dynamic> mydata;

  // collection reference
  final CollectionReference progCollection =
      FirebaseFirestore.instance.collection('userprogress');

  List getData(String week) {
    List mydata = [];
    progCollection.doc(uid).get().then((value) {
      {
        // print(value.data()['week1']);
        if (value.data()['$week'] != null) {
          //       tel = value.data()['week4'];
          //       print(tel);
          //     }
          mydata = value.data()['$week'];
        }
      }
    });
    return mydata;
  }

  void chngdata(String week, int dayNo, int prcntg) {
    List toEditList = [0, 0, 0, 0, 0, 0, 0];
    if (this.getData(week).length > 0) {
      toEditList = this.getData(week);
    }
    toEditList[dayNo] = prcntg;
    // print(toEditList);
    progCollection.doc(uid).update({
      '$week': toEditList,
    });
  }

  Stream get myStreem {
    return progCollection.doc(uid).snapshots();
  }

  // Future<void> updateUserData(
  //     String weekNo, String dayNo, int porgsprcntg) async {
  //   return await progCollection.doc(uid).set({

  //   });
  // }
}

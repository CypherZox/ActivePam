import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  // Map<dynamic, dynamic> mydata;
  List mydata = [];
  // collection reference
  final CollectionReference progCollection =
      FirebaseFirestore.instance.collection('userprogress');

  List getData(String week) {
    progCollection.get().then((value) {
      value.docs.forEach((element) {
        // print(element.data()['week1']);

        mydata = element.data()['$week'];
      });
    });
    return mydata;
  }

  void chngdata(String week, int dayNo, int prcntg) {
    List toEditList = this.getData(week);
    toEditList[dayNo] = prcntg;
    // print(toEditList);
    progCollection.doc('YONqggFiM2SUbuRLH2RQ').update({
      '$week': toEditList,
    });
  }

  Stream get myStreem {
    return progCollection.doc('YONqggFiM2SUbuRLH2RQ').snapshots();
  }

  // Future<void> updateUserData(
  //     String weekNo, String dayNo, int porgsprcntg) async {
  //   return await progCollection.doc(uid).set({

  //   });
  // }
}

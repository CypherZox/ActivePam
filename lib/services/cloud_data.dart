import 'package:cloud_firestore/cloud_firestore.dart';

class CloudData {
  final String uid;
  CloudData({this.uid});
  Map<String, dynamic> mydata;
  // collection reference
  final CollectionReference vidIds =
      FirebaseFirestore.instance.collection('vidIds');
  final CollectionReference weeksno =
      FirebaseFirestore.instance.collection('no_of_weeks');
  final Stream weeknostream = FirebaseFirestore.instance
      .collection('no_of_weeks')
      .doc('no_of_weeks')
      .snapshots();
  Map<String, dynamic> getData(String week, int dayNo) {
    vidIds.doc('$week').get().then((value) {
      // value.docs.forEach((element) {
      // print(element.data()['day1'].runtimeType);
      mydata = value.data()['day$dayNo'];
      // print(mydata['30min']);
    });
    return mydata;
  }

  Stream getweeksstream(String no) {
    return this.vidIds.doc('week$no').snapshots();
  }
  // void chngdata(String week, int dayNo, int prcntg) {
  //   List toEditList = this.getData(week);
  //   toEditList[dayNo] = prcntg;
  //   // print(toEditList);
  //   progCollection.doc('YONqggFiM2SUbuRLH2RQ').update({
  //     '$week': toEditList,
  //   });
  // }

  Stream get myStreem {
    return FirebaseFirestore.instance.collection('vidIds').snapshots();
  }

  // Future<void> updateUserData(
  //     String weekNo, String dayNo, int porgsprcntg) async {
  //   return await progCollection.doc(uid).set({

  //   });
  // }
}

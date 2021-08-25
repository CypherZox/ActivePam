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

      mydata = value.data()['day$dayNo'];
    });
    return mydata;
  }

  Stream getweeksstream(String no) {
    return this.vidIds.doc('week$no').snapshots();
  }

  Stream get myStreem {
    return FirebaseFirestore.instance.collection('vidIds').snapshots();
  }

}

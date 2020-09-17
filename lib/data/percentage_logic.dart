import 'package:flutter/cupertino.dart';

class PrcntgLogic extends ChangeNotifier {
  // int finished;
  // double unFinished;
  // int totalnum;
  double progressprcntg;
  // PrcntgLogic({this.finished, this.totalnum, this.unFinished});
  void getPrsntg(finished, unFinished, totalnum) {
    progressprcntg = ((finished + unFinished) / totalnum * 100);
    notifyListeners();
  }
}

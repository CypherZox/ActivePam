import 'package:flutter/cupertino.dart';
import 'package:get_active_prf/services/database_service.dart';

class PrcntgLogic extends ChangeNotifier {
  // int finished;
  // double unFinished;
  // int totalnum;
  DatabaseService databaseService = DatabaseService();
  double progressprcntg;
  // PrcntgLogic({this.finished, this.totalnum, this.unFinished});
  void getPrsntg(finished, unFinished, totalnum, String week, int day) {
    progressprcntg = ((finished + unFinished) / totalnum * 100);
    databaseService.chngdata(week, day, progressprcntg.toInt());
    notifyListeners();
  }
}

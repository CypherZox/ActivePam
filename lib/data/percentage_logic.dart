import 'package:flutter/cupertino.dart';
import 'package:get_active_prf/services/auth.dart';
import 'package:get_active_prf/services/database_service.dart';

class PrcntgLogic extends ChangeNotifier {
  // int finished;
  // double unFinished;
  // int totalnum;
  DatabaseService databaseService = DatabaseService();
  double progressprcntg;
  int weekprctng = 0;
  T sum<T extends dynamic>(T lhs, T rhs) => lhs + rhs;
  // PrcntgLogic({this.finished, this.totalnum, this.unFinished});
  void getPrsntg(finished, unFinished, totalnum, String week, int day) async {
    // int currentWeek = await DatabaseService().getcurrentweek();
    // int currenDay = await DatabaseService().getcurrentday();
    progressprcntg = ((finished + unFinished) / totalnum * 100);
    if (progressprcntg >= 0 && progressprcntg < 10000) {
      List<dynamic> weeklist =
          await databaseService.chngdata(week, day, progressprcntg.toInt());
      int weekprctng = ((((weeklist.reduce(sum)) * 100)) ~/ 600);
      print(weekprctng);
      databaseService.updateweekprcntg(weekprctng);
      changecurrents(weekprctng, progressprcntg);
      notifyListeners();
    }
  }

  int get getweekprcntg {
    return weekprctng;
  }

  void changecurrents(weekprcntge, dayprcntge) {
    if (weekprcntge >= 90) {
      databaseService.updatecurrentweek();
    }
    if (dayprcntge >= 94) {
      databaseService.updatecurrentday();
    }
  }
}

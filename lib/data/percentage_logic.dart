import 'package:flutter/cupertino.dart';
import 'package:get_active_prf/models/progress.dart';
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
  void getPrsntg(finished, unFinished, totalnum, String week, int day) async {
    UserProgress userProgress = await AuthService().getUserProgress();
    progressprcntg = ((finished + unFinished) / totalnum * 100);
    if (progressprcntg >= 0 && progressprcntg < 10000) {
      List<dynamic> weeklist =
          await databaseService.chngdata(week, day, progressprcntg.toInt());
      int weekprctng = ((((weeklist.reduce(sum)) * 100)) ~/ 500);
      if (weekprctng > userProgress.getprogressPrcntge()) {
        userProgress.setprogressPrcntge(weekprctng);
      }

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

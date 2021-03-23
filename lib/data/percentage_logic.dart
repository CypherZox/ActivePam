import 'package:flutter/cupertino.dart';
import 'package:get_active_prf/services/database_service.dart';

class PrcntgLogic extends ChangeNotifier {
  DatabaseService databaseService = DatabaseService();

  double progressprcntg;
  int weekprctng = 0;
  T sum<T extends dynamic>(T lhs, T rhs) => lhs + rhs;
  // PrcntgLogic({this.finished, this.totalnum, this.unFinished});
  void getPrsntg(finished, unFinished, totalnum, String week, int day) async {
    print('getprcntg func');
    // int currentWeek = await DatabaseService().getcurrentweek();
    // int currenDay = await DatabaseService().getcurrentday();
    progressprcntg = ((finished + unFinished) / totalnum * 100);
    print('progg = ' + progressprcntg.toString());
    if (progressprcntg >= 0 && progressprcntg < 10000) {
      print(day);
      List<dynamic> weeklist =
          await databaseService.chngdata(week, day, progressprcntg.toInt());
      print('week list' + weeklist.toString());
      int weekprctng = ((((weeklist.reduce(sum)) * 100)) ~/ 500);
      print('week prcntg is' + weekprctng.toString());
      databaseService.updateweekprcntg(weekprctng);
      changecurrents(weekprctng, progressprcntg);
      notifyListeners();
    }
  }

  int get getweekprcntg {
    return weekprctng;
  }

  void changecurrents(weekprcntge, dayprcntge) {
    if (weekprcntge >= 97) {
      databaseService.updatecurrentweek();
    }
    if (dayprcntge >= 97) {
      databaseService.updatecurrentday();
    }
  }
}

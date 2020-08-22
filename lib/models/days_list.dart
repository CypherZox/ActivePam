import 'package:get_active_prf/models/Day.dart';
import 'dart:collection';

class DaysData {
  List<Day> _days = [
    Day(no: 1, title: 'full body'),
    Day(no: 2, title: 'abs'),
    Day(no: 3, title: 'legs'),
    Day(no: 4, title: 'stretch'),
  ];
  UnmodifiableListView<Day> get days {
    return UnmodifiableListView(_days);
  }

  int get weeksCount {
    return _days.length;
  }
}

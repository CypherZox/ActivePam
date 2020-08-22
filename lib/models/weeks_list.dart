import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get_active_prf/models/week.dart';

class WeeksList {
  List<Week> _weeks = [
    Week(no: 1, color: Color(0xFFda8388)),
    Week(no: 2, color: Color(0xFFc09999)),
    Week(no: 3, color: Color(0xFFc0c0c0)),
  ];
  UnmodifiableListView<Week> get weeks {
    return UnmodifiableListView(_weeks);
  }

  int get weeksCount {
    return _weeks.length;
  }
}

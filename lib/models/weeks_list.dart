import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get_active_prf/models/week.dart';

class WeeksList {
  List<Week> _weeks = [
    Week(no: '1', color: Color(0xFFda8388)),
    Week(no: '2', color: Color(0xFFc09999)),
    Week(no: '3', color: Color(0xFFc0c0c0)),
    Week(no: '4', color: Color(0xFFda8388)),
    Week(no: '5', color: Color(0xFFc09999)),
    Week(no: '6', color: Color(0xFFc0c0c0)),
    Week(no: '7', color: Color(0xFFda8388)),
    Week(no: '8', color: Color(0xFFc09999)),
    Week(no: '9', color: Color(0xFFc0c0c0)),
    Week(no: '10', color: Color(0xFFda8388)),
    Week(no: '11', color: Color(0xFFc09999)),
    Week(no: '12', color: Color(0xFFc0c0c0)),
    Week(no: '13', color: Color(0xFFda8388)),
    Week(no: '14', color: Color(0xFFc09999)),
    Week(no: '15', color: Color(0xFFc0c0c0)),
    Week(no: '16', color: Color(0xFFda8388)),
    Week(no: '17', color: Color(0xFFc09999)),
    Week(no: '18', color: Color(0xFFc0c0c0)),
    Week(no: '19', color: Color(0xFFda8388)),
    Week(no: '20', color: Color(0xFFc09999)),
    Week(no: '21', color: Color(0xFFc0c0c0)),
    Week(no: '22', color: Color(0xFFda8388)),
    Week(no: '23', color: Color(0xFFc09999)),
    Week(no: '24', color: Color(0xFFc0c0c0)),
  ];
  UnmodifiableListView<Week> get weeks {
    return UnmodifiableListView(_weeks);
  }

  int get weeksCount {
    return _weeks.length;
  }
}

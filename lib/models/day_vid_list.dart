import 'dart:collection';

class DayVidList {
  List<String> _vids = ['DHOPWvO3ZcI', 'QN5Nu1aeYyc', 'QUn2iTnPOyw'];
  UnmodifiableListView<String> get vids {
    return UnmodifiableListView(_vids);
  }

  int get vidsCount {
    return _vids.length;
  }
}

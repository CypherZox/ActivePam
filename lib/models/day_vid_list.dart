class DayVidList {
  List getvids(int numberofweeks, int currentweek) {
    List vids = [for (var i = 1; i <= numberofweeks; i += 1) i];
    vids = vids.sublist(currentweek - 1) +
        List.from(vids.sublist(0, currentweek - 1).reversed);
    return vids;
  }

  List weekprcntg(int numberofweeks, int currentweek, weekprctng) {
    List vids = [for (var i = 1; i <= numberofweeks; i += 1) 0];
    vids = vids.sublist(currentweek - 1) +
        List.from(vids.sublist(0, currentweek - 1).reversed);
    vids[0] = weekprctng;
    return vids;
  }

  List flagvids(int numberofweeks, int currentweek) {
    List list = [for (var i = 1; i <= numberofweeks; i += 1) false];
    list.fillRange((numberofweeks - currentweek + 1), list.length, true);
    return list;
  }
}

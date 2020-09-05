import 'package:flutter/material.dart';
import 'package:get_active_prf/widgets/day_tilee.dart';

class DaysList extends StatelessWidget {
  final List<dynamic> vidIds;
  DaysList({this.vidIds});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        final vid = vidIds[index];
        return DayTilee(
          vidID: vid,
        );
      },
      itemCount: vidIds.length,
    );
  }
}

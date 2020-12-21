import 'package:flutter/material.dart';

import 'package:get_active_prf/widgets/new_day_tile.dart';

class DaysList extends StatelessWidget {
  final List<dynamic> vidIds;
  // final int prcntg;
  DaysList({
    this.vidIds,
    // this.prcntg
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              final vid = vidIds[index];
              return NewDayTile(
                vidID: vid,
              );
            },
            itemCount: vidIds.length,
          ),
        ),
        // Text('$prcntg%'),
      ],
    );
  }
}

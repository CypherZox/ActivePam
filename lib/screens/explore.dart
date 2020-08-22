import 'package:flutter/material.dart';
import 'package:get_active_prf/models/weeks_list.dart';
import 'package:get_active_prf/widgets/week_tile.dart';

class Explore extends StatefulWidget {
  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemBuilder: (context, index) {
          final week = WeeksList().weeks[index];
          return WeekTile(
            no: week.no,
            color: week.color,
          );
        },
        itemCount: WeeksList().weeksCount,
      ),
    );
  }
}

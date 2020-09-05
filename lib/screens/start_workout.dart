import 'package:flutter/material.dart';
import 'package:get_active_prf/models/days_list.dart';
import 'package:get_active_prf/widgets/circular_indicator.dart';
import 'package:get_active_prf/widgets/day_card_tile.dart';
import 'package:get_active_prf/widgets/start_button.dart';

class StartWorkout extends StatefulWidget {
  final int no;
  final String version;
  StartWorkout({this.no, this.version});
  @override
  _StartWorkoutState createState() => _StartWorkoutState();
}

class _StartWorkoutState extends State<StartWorkout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 13.0,
            ),
            CircularIndicator(),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  final day = DaysData().days[index];
                  return DayCardTile(
                    no: day.no,
                    title: day.title,
                  );
                },
                itemCount: DaysData().weeksCount,
              ),
            ),
            StartButton()
          ],
        ),
      ),
    );
  }
}

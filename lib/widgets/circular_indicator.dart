import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:flutter/material.dart';

class CircularIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      backgroundColor: Colors.grey.withOpacity(0.3),
      radius: 120.0,
      lineWidth: 13.0,
      animation: true,
      percent: 0.3,
      center: new Text(
        "30.0%",
        style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      circularStrokeCap: CircularStrokeCap.round,
      progressColor: Colors.green[300],
    );
  }
}

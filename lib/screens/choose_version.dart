import 'package:flutter/material.dart';
import 'package:get_active_prf/widgets/version_box.dart';

class ChooseVersion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Row(
              children: [
                SizedBox(
                  width: 31,
                ),
                VersionBox(
                  color: Color(0xFFda8388),
                  title: 'beginner',
                  sizeRation: 4.5,
                ),
                SizedBox(
                  width: 12,
                ),
                VersionBox(
                  color: Color(0xFFc09999),
                  title: '30 min',
                  sizeRation: 4.5,
                ),
                SizedBox(
                  width: 12,
                ),
                VersionBox(
                  color: Color(0xFFc0c0c0),
                  title: '45 min',
                  sizeRation: 4.5,
                ),
              ],
            ),
          ),
        ));
  }
}

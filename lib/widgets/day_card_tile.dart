import 'package:flutter/material.dart';
import 'package:get_active_prf/widgets/thembnail_avi.dart';
import 'package:get_active_prf/styles/decorations.dart';

class DayCardTile extends StatelessWidget {
  final int no;
  final String title;
  DayCardTile({this.no, this.title});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16.0),
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width - 60,
        height: 100,
        decoration: shadedboxdecoration.copyWith(color: Colors.white),
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 23.0, 0.0, 6.0),
                      child: Text(
                        'Day $no',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(23.0, 0.0, 0.0, 6.0),
                      child: Text(
                        '$title',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                ThumbNailAvi(),
                SizedBox(
                  width: 20,
                ),
                ThumbNailAvi(),
                SizedBox(
                  width: 20,
                ),
                ThumbNailAvi(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

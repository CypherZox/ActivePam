import 'package:flutter/material.dart';
import 'package:get_active_prf/screens/choose_version.dart';
import 'package:get_active_prf/styles/decorations.dart';

class WeekTile extends StatelessWidget {
  final Color color;
  final int no;
  WeekTile({
    this.color,
    this.no,
  });

  @override
  Widget build(BuildContext context) {
    var container = Container(
      width: 340,
      height: 75,
      decoration: shadedboxdecoration.copyWith(color: color),
      child: Center(
        child: Text(
          'Week $no',
          style: TextStyle(
              fontSize: 21.0, color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9.0),
      child: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ChooseVersion(no: no)));
            print(no);
          },
          child: container,
        ),
      ),
    );
  }
}

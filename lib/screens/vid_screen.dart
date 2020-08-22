import 'package:flutter/material.dart';
import 'package:get_active_prf/styles/decorations.dart';

class VidScreen extends StatefulWidget {
  @override
  _VidScreenState createState() => _VidScreenState();
}

class _VidScreenState extends State<VidScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 250,
            color: Colors.pink.withOpacity(0.1),
          ),
          SizedBox(
            height: 100,
          ),
          Text(
            'Coming next',
            style: TextStyle(
                color: Colors.grey[800],
                fontSize: 30,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 3.6,
            height: (MediaQuery.of(context).size.width / 5.0) * 2.5,
            decoration: shadedboxdecoration.copyWith(
                color: Colors.pinkAccent.withOpacity(0.3)),
          ),
        ],
      ),
    );
  }
}

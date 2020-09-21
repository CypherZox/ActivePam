import 'package:flutter/material.dart';

class JustAtest extends StatefulWidget {
  @override
  _JustAtestState createState() => _JustAtestState();
}

class _JustAtestState extends State<JustAtest>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  var shared = new List.filled(5, 0);
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(30.0, 70.0, 10.0, 0.0),
            child: Row(
              children: [
                SizedBox(
                  width: 20.0,
                ),
                GestureDetector(
                    child: Icon(
                  Icons.access_alarm,
                )),
                SizedBox(
                  width: 20.0,
                ),
                Icon(Icons.bubble_chart),
                SizedBox(
                  width: 20.0,
                ),
                Icon(Icons.keyboard)
              ],
            ),
          ),
          Container(
            height: 400.0,
            width: 350.0,
            decoration: BoxDecoration(
                color: Colors.blueGrey[900],
                borderRadius: BorderRadius.circular(30.0)),
          )
        ],
      ),
    );
  }
}

class Number extends StatelessWidget {
  final String no;
  Number({this.no});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: AnimatedContainer(
        duration: Duration(seconds: 3),
        height: 50.0,
        width: 40,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 13.0, 0.0, 0.0),
          child: Text(
            '$no',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
        ),
        decoration: BoxDecoration(
            color: Colors.blueGrey[900],
            borderRadius: BorderRadius.circular(30)),
      ),
    );
  }
}

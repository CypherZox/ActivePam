import 'package:flutter/material.dart';

class StartButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 21.0),
                  child: MaterialButton(
                    elevation: 3.0,
                    onPressed: () {},
                    color: Colors.green[300],
                    minWidth: MediaQuery.of(context).size.width - 60,
                    height: 40,
                    child: Text(
                      'Start',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            )));
  }
}

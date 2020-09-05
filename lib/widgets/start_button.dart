import 'package:flutter/material.dart';

class StartButton extends StatelessWidget {
  final Function onpressed;
  StartButton({this.onpressed});
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
                    onPressed: onpressed,
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

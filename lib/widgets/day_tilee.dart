import 'package:flutter/material.dart';

class DayTilee extends StatelessWidget {
  final String vidID;

  DayTilee({this.vidID});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Container(
        width: 306,
        height: 110,
        child: Row(
          children: [
            Image.network(
              'https://img.youtube.com/vi/$vidID/maxresdefault.jpg',
              fit: BoxFit.contain,
            ),
          ],
        ),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onPrimary,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), bottomLeft: Radius.circular(12))),
      ),
    );
  }
}

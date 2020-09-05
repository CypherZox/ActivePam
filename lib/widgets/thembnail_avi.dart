import 'package:flutter/material.dart';

class ThumbNailAvi extends StatefulWidget {
  final String vidID;
  ThumbNailAvi({this.vidID});

  @override
  _ThumbNailAviState createState() => _ThumbNailAviState();
}

class _ThumbNailAviState extends State<ThumbNailAvi> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {},
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  child: Image.network(
                    'https://img.youtube.com/vi/${widget.vidID}/maxresdefault.jpg',
                    width: 200,
                    height: 200,
                    fit: BoxFit.contain,
                  )),
            ),
          ],
        ));
  }
}

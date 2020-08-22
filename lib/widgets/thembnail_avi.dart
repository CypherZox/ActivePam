import 'package:flutter/material.dart';

class ThumbNailAvi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: CircleAvatar(
        radius: 32,
        backgroundColor: Colors.pink.withOpacity(0.3),
      ),
    );
  }
}

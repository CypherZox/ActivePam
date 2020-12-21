import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class NewDayTile extends StatelessWidget {
  final String vidID;
  NewDayTile({this.vidID});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9.0, horizontal: 4.0),
      child: SizedBox(
        child: Align(
          alignment: Alignment.topLeft,
          child: Container(
            width: 155,
            // height: 150,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(0)),
            child: Padding(
              padding:
                  //'https://img.youtube.com/vi/$vidID/maxresdefault.jpg'
                  const EdgeInsets.symmetric(horizontal: 1.5, vertical: 1.5),
              child: Column(children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(2.5),
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://img.youtube.com/vi/$vidID/maxresdefault.jpg',
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

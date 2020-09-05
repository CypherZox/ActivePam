import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class DataService {
  Future<Map<String, dynamic>> parseJsonFromAssets(String assetsPath) async {
    print('--- Parse json from: $assetsPath');
    final data = await rootBundle.loadString(assetsPath);
    return jsonDecode(data);
    // print(jsonDecode(data));
  }
}

// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'package:get_active_prf/utilities/keys.dart';
// import 'package:get_active_prf/models/video_model.dart';

// class APIService {
//   APIService._instantiate();

//   static final APIService instance = APIService._instantiate();

//   final String _baseUrl = 'www.googleapis.com';

//   Future<Video> fetchVideo({String vidId}) async {
//     Map<String, String> parameters = {
//       'part': 'snippet,contentDetails,statistics',
//       'id': vidId,
//       'key': API_KEY,
//     };
//     Uri uri = Uri.https(
//       _baseUrl,
//       '/youtube/v3/videos',
//       parameters,
//     );
//     Map<String, String> headers = {
//       HttpHeaders.contentTypeHeader: 'application/json',
//     };

//     // Get Channel
//     var response = await http.get(uri, headers: headers);
//     if (response.statusCode == 200) {
//       Map<String, dynamic> data = json.decode(response.body)['items'][0];
//       Video video = Video.fromMap(data);
//       print(video.thumbnailUrl);
//       // Fetch first batch of videos from uploads playlist
//       return video;
//     } else {
//       throw json.decode(response.body)['error']['message'];
//     }
//   }
// }

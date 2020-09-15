import 'package:get_active_prf/services/data_service.dart';

class VideoModel {
  final List<dynamic> vidIds;
  final String title;
  VideoModel({this.vidIds, this.title});

  Future<List<dynamic>> getIDs(
      String dayNo, String weekNo, String version) async {
    Map<String, dynamic> dmap =
        await DataService().parseJsonFromAssets('assets/week$weekNo.json');
    //  print(dmap['day$dayNo']['$version']['vids'].runtimeType);
    return dmap['day$dayNo']['$version']['vids'];
  }
}

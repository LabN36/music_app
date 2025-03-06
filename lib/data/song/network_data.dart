import 'dart:convert';

import 'package:music_app/network_helper/network_helper.dart';

import 'song_data_source.dart';
import 'song_model.dart';

class SongNetworkData implements SongDataSource {
  APIClient apiClient;
  SongNetworkData(this.apiClient);
  @override
  Future<List<SongModel>?> getSongs() async {
    String url =
        'https://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/topsongs/limit=20/json';
    final data = await apiClient.get(url);
    if (data.isNotEmpty) {
      //for now we're certain that API will return the data
      final json = jsonDecode(data);
      final entry = json['feed']['entry'] as List;
      final songs = entry.map<SongModel>((item) {
        return SongModel.fromJson(item);
      }).toList();
      return songs;
    } else {
      throw Exception('Failed to load songs');
    }
  }
}

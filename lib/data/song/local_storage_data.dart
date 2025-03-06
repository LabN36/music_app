import 'dart:convert';

import 'package:music_app/db_helper/db_helper.dart';

import 'song_data_source.dart';
import 'song_model.dart';

class SongLocalStorageData implements SongDataSource {
  AbstractDBHelder dbHelper;
  SongLocalStorageData(this.dbHelper);
  @override
  Future<List<SongModel>?> getSongs() async {
    final songsString = await dbHelper.getData('songs');
    if (songsString != null) {
      final json = jsonDecode(songsString);
      final songs =
          json.map<SongModel>((item) => SongModel.fromJson(item)).toList();
      return Future.value(songs);
    }
    return Future.value(<SongModel>[]);
  }

  saveSongs(List<SongModel>? songs) {
    final songsString = jsonEncode(songs);
    dbHelper.insertData('songs', songsString);
  }
}

import 'package:music_app/domain/song/song_entity.dart';
import 'package:music_app/domain/song/song_repository.dart';

import 'song/local_storage_data.dart';
import 'song/network_data.dart';

class SongRepositoryImpl implements SongRepository {
  final SongNetworkData songNetworkData;
  final SongLocalStorageData songLocalStorageData;

  SongRepositoryImpl({
    required this.songNetworkData,
    required this.songLocalStorageData,
  });

  @override
  Future<List<SongEntity>> getSongs() async {
    try {
      final songs = await songLocalStorageData.getSongs();
      if (songs != null) {
        return songs.map((e) => SongEntity.fromSong(e)).toList();
      } else {
        final songs = await songNetworkData.getSongs();
        if (songs != null) {
          await songLocalStorageData.saveSongs(songs);
          return songs.map((e) => SongEntity.fromSong(e)).toList();
        }
        return [];
      }
    } on Exception {
      rethrow;
    }
  }
}

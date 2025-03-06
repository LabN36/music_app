import 'song_model.dart';

abstract class SongDataSource {
  Future<List<SongModel>?> getSongs();
}

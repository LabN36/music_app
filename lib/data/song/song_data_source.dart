import 'song_model.dart';

abstract class SongDataSource {
  Future<SongModel> getSongs();
}

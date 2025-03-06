import 'song_entity.dart';

abstract class SongRepository {
  Future<List<SongEntity>> getSongs();
}

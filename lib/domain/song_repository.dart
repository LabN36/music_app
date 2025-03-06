import 'package:music_app/domain/song_entity.dart';

abstract class SongRepository {
  Future<List<SongEntity>> getSongs();
}

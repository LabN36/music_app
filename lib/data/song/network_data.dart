import 'song_data_source.dart';
import 'song_model.dart';

class SongNetwork implements SongDataSource {
  @override
  Future<SongModel> getSongs() {
    throw UnimplementedError();
  }
}

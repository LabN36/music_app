import 'song_data_source.dart';
import 'song_model.dart';

class SongLocalStorageData implements SongDataSource {
  @override
  Future<List<SongModel>?> getSongs() {
    throw UnimplementedError();
  }
}

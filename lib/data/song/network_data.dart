import 'song_data_source.dart';
import 'song_model.dart';

class SongNetworkData implements SongDataSource {
  @override
  Future<List<SongModel>?> getSongs() {
    throw UnimplementedError();
  }
}

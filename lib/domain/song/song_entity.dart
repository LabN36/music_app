import 'package:music_app/data/song/song_model.dart';

class SongEntity {
  final String title;
  final String artistName;
  final List<String> albumImages;
  const SongEntity(this.title, this.artistName, this.albumImages);

  static SongEntity fromSong(SongModel songModel) {
    return SongEntity(
        songModel.title, songModel.artistName, songModel.albumImages);
  }
}

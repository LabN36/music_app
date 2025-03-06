import 'package:music_app/data/song/song_model.dart';

class SongEntity {
  final String id;
  final String title;
  final String artistName;
  final List<String> albumImages;
  const SongEntity(this.id, this.title, this.artistName, this.albumImages);

  static SongEntity fromSong(SongModel songModel) {
    return SongEntity(
      songModel.id,
      songModel.title,
      songModel.artistName,
      songModel.albumImages,
    );
  }
}

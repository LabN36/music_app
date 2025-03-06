class SongModel {
  final String title;
  final String artistName;
  final List<String> albumImages;
  const SongModel(this.title, this.artistName, this.albumImages);

  static fromJson(item) {
    return SongModel(
      item['title'],
      item['artistName'],
      item['albumImages'],
    );
  }
}

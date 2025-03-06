class SongModel {
  final String id;
  final String title;
  final String artistName;
  final List<String> albumImages;
  const SongModel(this.id, this.title, this.artistName, this.albumImages);

  static SongModel fromCache(Map<String, dynamic> item) {
    List<String> list = item['albumImages'].cast<String>();
    return SongModel(item['id'], item['title'], item['artistName'], list);
  }

  static fromJson(Map<String, dynamic> item) {
    return SongModel(
      item['id']['attributes']['im:id'],
      item['title']['label'],
      item['im:artist']['label'],
      (item['im:image'] as List)
          .map<String>((image) => image['label'])
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'artistName': artistName,
      'albumImages': albumImages,
    };
  }
}

import 'dart:convert';

class SongModel {
  final String title;
  final String artistName;
  final List<String> albumImages;
  const SongModel(this.title, this.artistName, this.albumImages);

  static SongModel fromCache(Map<String, dynamic> item) {
    List<String> _list = item['albumImages'].cast<String>();
    return SongModel(item['title'], item['artistName'], _list);
  }

  static fromJson(Map<String, dynamic> item) {
    return SongModel(
      item['title']['label'],
      item['im:artist']['label'],
      (item['im:image'] as List)
          .map<String>((image) => image['label'])
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'artistName': artistName,
      'albumImages': albumImages,
    };
  }
}

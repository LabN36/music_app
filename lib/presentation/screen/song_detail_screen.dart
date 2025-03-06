import 'package:flutter/material.dart';
import 'package:music_app/domain/song/song_entity.dart';
import 'package:music_app/presentation/widget/alumb_image_widget.dart';

class SongDetailScreen extends StatelessWidget {
  final SongEntity song;
  const SongDetailScreen(this.song, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Song Detail Screen'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              AlbumImage(song.albumImages[2]),
              Text('Title: ${song.title}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  )),
              Text('Artist: ${song.artistName}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

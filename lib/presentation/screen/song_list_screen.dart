import 'package:flutter/material.dart';
import 'package:music_app/data/song_repository.dart';
import 'package:music_app/domain/song_entity.dart';

class SongListScreen extends StatefulWidget {
  final SongRepositoryImpl songRepository;
  const SongListScreen(this.songRepository, {super.key});

  @override
  State<SongListScreen> createState() => _SongListScreenState();
}

class _SongListScreenState extends State<SongListScreen> {
  late Future<List<SongEntity>> fetchSongFuture;

  @override
  void initState() {
    super.initState();
    fetchSongFuture = widget.songRepository.getSongs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Music App'),
      ),
      body: FutureBuilder<List<SongEntity>>(
          future: fetchSongFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      print('Tapped');
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      constraints: const BoxConstraints(
                        maxHeight: 80,
                      ),
                      child: Row(
                        children: [
                          Image.network(
                            snapshot.data![index].albumImages[2],
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return const CircularProgressIndicator();
                            },
                            // errorBuilder: (context, error, stackTrace) =>
                            //     Container(
                            //   height: 80,
                            //   width: 80,
                            // ),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Title: ${snapshot.data![index].title}',
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    'Artist: ${snapshot.data![index].artistName}',
                                    overflow: TextOverflow.ellipsis,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          }),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:music_app/data/song/network_data.dart';
import 'package:music_app/db_helper/db_helper.dart';
import 'package:music_app/domain/song_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/song/local_storage_data.dart';
import 'data/song_repository.dart';
import 'network_helper/network_helper.dart';

void main() async {
  //bypassing ssl for now
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  final client = APIClient(IOClient(HttpClient()));
  final songNetworkData = SongNetworkData(client);
  final songLocalStorageData =
      SongLocalStorageData(DBHelper(sharedPreferences));
  final songRepository = SongRepositoryImpl(
    songNetworkData: songNetworkData,
    songLocalStorageData: songLocalStorageData,
  );
  runApp(MyApp(songRepository: songRepository));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.songRepository});
  final SongRepositoryImpl songRepository;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(songRepository),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final SongRepositoryImpl songRepository;
  const MyHomePage(this.songRepository, {super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:music_app/data/song/network_data.dart';
import 'package:music_app/db_helper/db_helper.dart';
import 'package:music_app/presentation/screen/song_list_screen.dart';
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
      home: SongListScreen(songRepository),
    );
  }
}

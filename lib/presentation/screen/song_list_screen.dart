import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/presentation/bloc/song_bloc.dart';

import 'cart_screen.dart';

class SongListScreen extends StatefulWidget {
  const SongListScreen({super.key});

  @override
  State<SongListScreen> createState() => _SongListScreenState();
}

class _SongListScreenState extends State<SongListScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SongCubit>(context).getSongs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Music App'),
        actions: [
          GestureDetector(
            onTap: () {
              print('Cart');
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const CartScreen()));
            },
            child: Text('Total Items: 0'),
          )
        ],
      ),
      body: BlocBuilder<SongCubit, SongState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.error.isNotEmpty) {
            return Center(child: Text('Error: ${state.error}'));
          }
          return ListView.builder(
              itemCount: state.songs!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    print('Tapped');
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    constraints: const BoxConstraints(
                      maxHeight: 100,
                    ),
                    child: Row(
                      children: [
                        Image.network(
                          state.songs![index].albumImages[2],
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
                                  'Title: ${state.songs![index].title}',
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  'Artist: ${state.songs![index].artistName}',
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          print('Remove');
                                        },
                                        icon: const Icon(Icons.remove)),
                                    Text('0'),
                                    IconButton(
                                        onPressed: () {
                                          print('Add');
                                        },
                                        icon: const Icon(Icons.add)),
                                    IconButton(
                                        onPressed: () {
                                          print('Listen');
                                        },
                                        icon: const Icon(Icons.music_note))
                                  ],
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
        },
      ),
    );
  }
}

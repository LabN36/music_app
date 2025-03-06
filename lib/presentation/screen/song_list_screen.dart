import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/domain/song/song_entity.dart';
import 'package:music_app/presentation/bloc/cart_bloc.dart';
import 'package:music_app/presentation/bloc/song_bloc.dart';
import 'package:music_app/presentation/screen/song_detail_screen.dart';
import 'package:music_app/presentation/widget/alumb_image_widget.dart';

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
            child: BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                return Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(8),
                    child: Text('Cart : ${state.total}'));
              },
            ),
          )
        ],
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, cartState) {
          return BlocBuilder<SongCubit, SongState>(
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
                    return SongItemWidget(state.songs![index], cartState);
                  });
            },
          );
        },
      ),
    );
  }
}

class SongItemWidget extends StatelessWidget {
  final SongEntity songEntity;
  final CartState cartState;
  const SongItemWidget(
    this.songEntity,
    this.cartState, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SongDetailScreen(songEntity)),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        constraints: const BoxConstraints(
          maxHeight: 100,
        ),
        child: Row(
          children: [
            AlbumImage(songEntity.albumImages[2]),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getTitleWidget(),
                    getArtistWidget(),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () => BlocProvider.of<CartCubit>(context)
                                .removeItem(songEntity),
                            icon: const Icon(Icons.remove)),
                        cartState.items.containsKey(songEntity.id)
                            ? Text(
                                cartState.items[songEntity.id]!.quantity
                                    .toString(),
                              )
                            : const Text('0'),
                        IconButton(
                            onPressed: () => BlocProvider.of<CartCubit>(context)
                                .addItem(songEntity),
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
  }

  Text getArtistWidget() {
    return Text(
      'Artist: ${songEntity.artistName}',
      overflow: TextOverflow.ellipsis,
    );
  }

  Text getTitleWidget() {
    return Text(
      'Title: ${songEntity.title}',
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    );
  }
}

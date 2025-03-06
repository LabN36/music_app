import 'package:flutter/material.dart';

class AlbumImage extends StatelessWidget {
  final String src;
  const AlbumImage(this.src, {super.key});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      src,
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
    );
  }
}

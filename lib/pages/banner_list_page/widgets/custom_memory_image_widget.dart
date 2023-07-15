import 'dart:typed_data';

import 'package:flutter/material.dart';

class CustomMemoryImageWidget extends StatelessWidget {
  const CustomMemoryImageWidget({
    Key? key,
    required this.image,
    required this.height,
    required this.width,
  }) : super(key: key);

  final List<int> image;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Image.memory(
      Uint8List.fromList(
        image,
      ),
      height: height,
      width: width,
      fit: BoxFit.cover,
      gaplessPlayback: true,
    );
  }
}

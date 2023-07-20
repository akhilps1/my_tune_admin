import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomCatchedNetworkImage extends StatelessWidget {
  const CustomCatchedNetworkImage({
    Key? key,
    required this.url,
    this.showIcon = false,
  }) : super(key: key);

  final String url;
  final bool showIcon;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      height: double.infinity,
      width: double.infinity,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: Colors.blue,
        highlightColor: Colors.red,
        child: Container(
          color: Colors.grey.withOpacity(0.2),
        ),
      ),
      errorWidget: (context, url, error) => Icon(
        showIcon == false ? Icons.error : Icons.person_outline,
        size: 40,
      ),
    );
  }
}

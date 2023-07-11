import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../model/banner_list_model/banner_list_model.dart';

class CustomCatchedNetworkImage extends StatelessWidget {
  const CustomCatchedNetworkImage({
    Key? key,
    required this.banner,
  }) : super(key: key);

  final BannerModel banner;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: banner.imageUrl,
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
      placeholder: (context, url) => Container(
        color: Colors.grey.withOpacity(0.2),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}

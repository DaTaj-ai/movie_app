import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movie_app/features/movies/domain/entities/movie_entity.dart';
import 'package:shimmer/shimmer.dart';

class AppNetworkImage extends StatelessWidget {
  final String url;
  final double width;
  final double height;
  final Movie movie;
  final VoidCallback? onTap;

  const AppNetworkImage({
    super.key,
    required this.url,
    required this.width,
    required this.height,
    required  this.movie,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return     GestureDetector(
        onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: CachedNetworkImage(
          imageUrl: url,
          width: width,
          height: height,
          fit: BoxFit.contain,
          placeholder: (context, _) => Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              width: width,
              height: height,
              color: Colors.white,
            ),
          ),
          errorWidget: (context, _, __) => Container(
            width: width,
            height: height,
            color: Colors.grey.shade300,
            child: const Icon(Icons.broken_image, color: Colors.grey, size: 40),
          ),
        ),
      ),
    );
  }
}

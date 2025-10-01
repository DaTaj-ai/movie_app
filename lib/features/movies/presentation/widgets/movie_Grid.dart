import 'package:flutter/material.dart';
import '../../../../core/widget/app_network_image.dart';
import 'MovieDetailDialog.dart';
import '../../domain/entities/movie_entity.dart';

class ImageGrid extends StatefulWidget {
  final List<Movie> movies;
  final ScrollController? controller;
  final VoidCallback? onLoadMore;
  final bool isLoadingMore; // optional flag to show loader & prevent duplicate calls

  const ImageGrid({
    super.key,
    required this.movies,
    this.controller,
    this.onLoadMore,
    this.isLoadingMore = false,
  });

  @override
  State<ImageGrid> createState() => _ImageGridState();
}

class _ImageGridState extends State<ImageGrid> {
  late final ScrollController _controller;
  late final bool _usingExternalController;

  static const double itemW = 100;
  static const double itemH = 145.918;

  @override
  void initState() {
    super.initState();
    _usingExternalController = widget.controller != null;
    _controller = widget.controller ?? ScrollController();
    _controller.addListener(_onScroll);
  }

  @override
  void didUpdateWidget(covariant ImageGrid oldWidget) {
    super.didUpdateWidget(oldWidget);
    // If parent swapped controllers, update listener safely
    if (oldWidget.controller != widget.controller) {
      if (!_usingExternalController) {
        _controller.removeListener(_onScroll);
        _controller.dispose();
      }
      _usingExternalController = widget.controller != null;
      _controller = widget.controller ?? ScrollController();
      _controller.addListener(_onScroll);
    }
  }

  void _onScroll() {
    if (widget.onLoadMore == null) return; // nothing to do if no callback
    // trigger when close to bottom and not already loading more
    final max = _controller.position.maxScrollExtent;
    final pos = _controller.position.pixels;
    if (pos >= max - 200 && !widget.isLoadingMore) {
      widget.onLoadMore!.call();
    }
  }

  String _fullPosterUrl(String? path) {
    if (path == null || path.isEmpty) return '';
    if (path.startsWith('http')) return path;
    return 'https://image.tmdb.org/t/p/w500$path';
  }

  @override
  void dispose() {
    _controller.removeListener(_onScroll);
    if (!_usingExternalController) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.movies.isEmpty) {
      return const Center(child: Text('No movies'));
    }

    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 24, right: 24),
      child: Column(
        children: [
          GridView.builder(
            controller: _controller,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.movies.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 14,
              mainAxisSpacing: 18.8,
              childAspectRatio: itemW / itemH,
            ),
            itemBuilder: (context, index) {
              final poster = _fullPosterUrl(widget.movies[index].posterPath);
              return ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: SizedBox(
                  width: itemW,
                  height: itemH,
                  child: AppNetworkImage(
                    onTap:() {
                      showMovieDetailDialog(context, widget.movies[index]);
                    },
                    movie: widget.movies[index] ,
                    url: poster,
                    width: itemW,
                    height: itemH,
                  ),
                ),
              );
            },
          ),
          if (widget.isLoadingMore) ...[
            const SizedBox(height: 12),
            const CircularProgressIndicator(),
          ],
        ],
      ),
    );
  }

}



// import 'package:flutter/material.dart';
// import '../../../../core/widget/app_network_image.dart';
// import '../../domain/entities/movie_entity.dart';
//
// class ImageGrid extends StatelessWidget {
//   final List<Movie> movies;
//   final ScrollController? controller;
//
//   // width/height values
//   static const double itemW = 100;
//   static const double itemH = 145.918;
//
//   const ImageGrid({
//     super.key,
//     required this.movies,
//     this.controller,
//   });
//
//   String _fullPosterUrl(String? path) {
//     if (path == null || path.isEmpty) return '';
//     if (path.startsWith('http')) return path;
//     return 'https://image.tmdb.org/t/p/w500$path';
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (movies.isEmpty) {
//       return const Center(child: Text('No movies'));
//     }
//
//     return Padding(
//       padding: const EdgeInsets.only(top: 20, left: 24, right: 24),
//       child: GridView.builder(
//         controller: controller,
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(), // parent scroll handles it
//         itemCount: movies.length,
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 3,
//           crossAxisSpacing: 14,
//           mainAxisSpacing: 18.8,
//           childAspectRatio: itemW / itemH,
//         ),
//         itemBuilder: (context, index) {
//           final poster = _fullPosterUrl(movies[index].posterPath);
//
//           return ClipRRect(
//             borderRadius: BorderRadius.circular(16),
//             child: SizedBox(
//               width: itemW,
//               height: itemH,
//               child: AppNetworkImage(
//                 url: poster,
//                 width: itemW,
//                 height: itemH,
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//
//

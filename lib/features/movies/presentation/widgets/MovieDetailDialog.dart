import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/app_colors.dart';
import 'package:movie_app/core/widget/app_network_image.dart';
import 'package:movie_app/features/movies/domain/entities/movie_entity.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/widget/reusable_tab_bar.dart';

class MovieDetailDialog extends StatelessWidget {
  final Movie movie;
  final double height;
  final EdgeInsets padding;

  const MovieDetailDialog({
    super.key,
    required this.movie,
    this.height = 410,
    this.padding = const EdgeInsets.only(left: 12 , right: 12),
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.all(16),
      child: SizedBox(
        height: height,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppNetworkImage(
                  url: "${ApiConstants.imageBaseUrl}${movie.posterPath}",
                  width: double.infinity,
                  height: 179,
                  movie: movie,
                ),
                SizedBox(height: 24.0,),
                ReusableTabBar(
                  tabs: const ["About movie", "Reviews", "Cast"],
                  selectedIndex: 0,
                  onTap: (index) {},
                  indicatorColor: AppColors.black,
                  textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                  selectedColor: AppColors.black,
                  unselectedColor: AppColors.black,
                  horizontal_padding: 12.0,
                ),
                SizedBox(height: 24.0,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  movie.title,
                  style: const TextStyle(
                    fontFamily: "SF Pro Display",
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    height: 24 / 18,
                    letterSpacing: 0,
                  ),
                ),
              ),
                SizedBox(height: 8.0,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    movie.overview,
                    style: const TextStyle(
                      fontFamily: 'SF Pro Text',
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 16,
                      height: 24 / 16,
                      letterSpacing: 0.0, 
                    ),
                  ),
                ),
            
              ],
            ),
          ),
        ),
    );
  }
}

void showMovieDetailDialog(BuildContext context, Movie movie) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "MovieDetails",
    barrierColor: Colors.black54,
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (_, __, ___) => const SizedBox.shrink(),
    transitionBuilder: (_, anim, __, ___) {
      return FadeTransition(
        opacity: anim,
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.9, end: 1.0).animate(
            CurvedAnimation(parent: anim, curve: Curves.easeOut),
          ),
          child: MovieDetailDialog(movie: movie),
        ),
      );
    },
  );
}

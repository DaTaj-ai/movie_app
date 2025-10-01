import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widget/App_network_image.dart';
import 'MovieDetailDialog.dart';
import '../cubit/movie_cubit/movie_cubit.dart';
import '../cubit/movie_cubit/movie_state.dart';

// flag
class AutoImageCarousel extends StatefulWidget {
  final double height;
  final double width;

  const AutoImageCarousel({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  State<AutoImageCarousel> createState() => _AutoImageCarouselState();
}

class _AutoImageCarouselState extends State<AutoImageCarousel> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieCubit, MovieState>(
      builder: (context, state) {
        final movies = state.movies;

        if (state.isLoading && movies.isEmpty) {
          return SizedBox(
            height: widget.height,
            child: const Center(child: CircularProgressIndicator()),
          );
        }

        if (movies.isEmpty) {
          return SizedBox(
            height: widget.height,
            child: const Center(child: Text('No movies')),
          );
        }

        final double numberBoxWidth = 70;
        final double numberBoxHeight = 140;
        final double leftHang = 0;
        final double verticalOverlap = 80;

        return SizedBox(
          height: widget.height + numberBoxHeight * 0.6,
          child: CarouselSlider.builder(
            itemCount: movies.length,
            options: CarouselOptions(
              height: widget.height,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              viewportFraction: 0.44,
              padEnds: true,
              onPageChanged: (index, reason) {
                setState(() => _currentIndex = index);
              },
            ),
            itemBuilder: (context, index, realIdx) {
              final movie = movies[index];
              final displayNumber = (index + 1).toString();

              return SizedBox(
                width: widget.width,
                height: widget.height + numberBoxHeight * 0.8,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: SizedBox(
                          width: widget.width,
                          height: widget.height,
                          child: AppNetworkImage(
                            url: "${ApiConstants.imageBaseUrl}${movie.posterPath}",
                            width: widget.width,
                            height: widget.height,
                            movie: movie,
                            onTap: () => showMovieDetailDialog(context, movie),
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      left: leftHang,
                      top: widget.height - verticalOverlap,
                      child: SizedBox(
                        width: numberBoxWidth,
                        height: numberBoxHeight,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Text(
                                displayNumber,
                                style: TextStyle(
                                  fontSize: 700,
                                  fontWeight: FontWeight.bold,
                                  foreground: Paint()
                                    ..style = PaintingStyle.stroke
                                    ..strokeWidth = 10.0
                                    ..color = AppColors.myBlue,
                                ),
                              ),

                              Text(
                                displayNumber,
                                style: TextStyle(
                                  fontSize: 700,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.backgroundColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}

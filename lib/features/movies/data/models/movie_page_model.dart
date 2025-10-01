import '../../domain/entities/movie_page.dart';
import 'movie_model.dart';

class MoviePageModel {
  final int page;
  final List<MovieModel> results;
  final int totalPages;
  final int totalResults;

  MoviePageModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MoviePageModel.fromJson(Map<String,dynamic> json) {
    return MoviePageModel(
      page: (json['page'] ?? 1) as int,
      results: (json['results'] as List<dynamic>? ?? [])
          .map((e) => MovieModel.fromJson(e as Map<String,dynamic>))
          .toList(),
      totalPages: (json['total_pages'] ?? 1) as int,
      totalResults: (json['total_results'] ?? 0) as int,
    );
  }

  MoviePage toEntity() => MoviePage(
    page: page,
    results: results.map((m) => m.toEntity()).toList(),
    totalPages: totalPages,
    totalResults: totalResults,
  );
}

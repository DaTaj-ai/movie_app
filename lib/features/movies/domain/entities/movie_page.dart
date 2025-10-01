import 'movie_entity.dart';

class MoviePage {
  final int page;
  final List<Movie> results;
  final int totalPages;
  final int totalResults;

  const MoviePage({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });
}

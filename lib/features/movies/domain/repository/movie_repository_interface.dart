import '../entities/movie_entity.dart';
import '../entities/movie_page.dart';

abstract class MovieRepository {
  Future<List<Movie>> getTrendingMovies();
  Future<MoviePage> getMovies({required String category, int page = 1});
}

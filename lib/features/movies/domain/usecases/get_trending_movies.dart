
import '../entities/movie_entity.dart';
import '../repository/movie_repository_interface.dart';

class GetTrendingMovies {
  final MovieRepository repository;
  GetTrendingMovies(this.repository);

  Future<List<Movie>> call() => repository.getTrendingMovies();
}

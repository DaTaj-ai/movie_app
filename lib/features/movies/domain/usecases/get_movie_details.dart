
import '../entities/movie_entity.dart';
import '../repository/movie_repository_interface.dart';

class GetMovieDetails {
  final MovieRepository repository;
  GetMovieDetails(this.repository);

  Future<Movie> call(int id) => repository.getMovieDetails(id);
}

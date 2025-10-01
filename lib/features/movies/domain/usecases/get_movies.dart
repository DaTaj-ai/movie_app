import '../entities/movie_page.dart';
import '../repository/movie_repository_interface.dart';

class GetMovies {
  final MovieRepository repository;
  GetMovies(this.repository);

  Future<MoviePage> call({required String category, int page = 1}) {
    return repository.getMovies(category: category, page: page);
  }
}

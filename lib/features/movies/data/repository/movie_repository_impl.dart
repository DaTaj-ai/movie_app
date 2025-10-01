
import '../../domain/entities/movie_entity.dart';
import '../../domain/entities/movie_page.dart';
import '../../domain/repository/movie_repository_interface.dart';
import '../datasource/remote_movie_datasource/remote_movie_datasource.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;
  MovieRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Movie>> getTrendingMovies() async {
    final models = await remoteDataSource.fetchTrendingMovies();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<MoviePage> getMovies({required String category, int page = 1}) async {
    final model = await remoteDataSource.fetchMovies(category: category, page: page);
    return model.toEntity();
  }

  @override
  Future<Movie> getMovieDetails(int id) async {
    final model = await remoteDataSource.fetchMovieDetails(id: id);
    return model.toEntity();
  }
}

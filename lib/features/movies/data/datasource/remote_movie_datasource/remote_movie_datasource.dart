import 'package:dio/dio.dart';
import '../../../../../core/constants/api_constants.dart';
import '../../models/movie_model.dart';
import '../../models/movie_page_model.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> fetchTrendingMovies();
  Future<MoviePageModel> fetchMovies({required String category, required int page});
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final Dio dio;
  MovieRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<MovieModel>> fetchTrendingMovies() async {
    final response = await dio.get('/trending/movie/day',
        queryParameters: {
          "api_key": ApiConstants.bearerToken ,
      'language': 'en-US',
    });

    if (response.statusCode == 200) {
      final data = response.data as Map<String, dynamic>;
      final results = (data['results'] as List<dynamic>?) ?? [];
      return results
          .map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Failed to load trending movies (status ${response.statusCode})');
    }
  }

  @override
  Future<MoviePageModel> fetchMovies({
    required String category,
    required int page,
  }) async {
    final response = await dio.get(
      '/movie/$category',
      queryParameters: {
        'page': page,
        'language': 'en-US',
      },
    );

    return MoviePageModel.fromJson(response.data as Map<String, dynamic>);
  }


}

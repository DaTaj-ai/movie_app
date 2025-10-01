import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_app/features/movies/presentation/cubit/bottom_navigation_bar_cubit/bottom_navigation_bar_cubit.dart';
import '../../features/movies/data/datasource/remote_movie_datasource/remote_movie_datasource.dart';
import '../../features/movies/data/repository/movie_repository_impl.dart';
import '../../features/movies/domain/repository/movie_repository_interface.dart';
import '../../features/movies/domain/usecases/get_movies.dart';
import '../../features/movies/domain/usecases/get_trending_movies.dart';
import '../../features/movies/presentation/cubit/movie_list_cubit/movie_list_cubit.dart';
import '../../features/movies/presentation/cubit/trending_movie_cubit/trending_movie_cubit.dart';
import '../constants/api_constants.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<Dio>(() {
    final options = BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Authorization': 'Bearer ${ApiConstants.bearerToken}',
        'accept': 'application/json',
      },
    );
    return Dio(options);
  });
  sl.registerLazySingleton<MovieRemoteDataSource>(
        () => MovieRemoteDataSourceImpl(dio: sl()),
  );
  sl.registerLazySingleton<MovieRepository>(
        () => MovieRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<GetTrendingMovies>(() => GetTrendingMovies(sl()));
  sl.registerLazySingleton<GetMovies>(() => GetMovies(sl()));
  sl.registerFactory<TrendingCubit>(() => TrendingCubit(getTrendingMovies: sl()));
  sl.registerFactory<MovieListCubit>(() => MovieListCubit(sl()));
  sl.registerFactory<BottomNavBarCubit>(() => BottomNavBarCubit());
}

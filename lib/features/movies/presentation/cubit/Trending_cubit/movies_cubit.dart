// lib/presentation/cubit/trending_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/usecases/get_trending_movies.dart';
import 'movies_state.dart';


class TrendingCubit extends Cubit<TrendingState> {
  final GetTrendingMovies getTrendingMovies;
  TrendingCubit({required this.getTrendingMovies}) : super(TrendingInitial());

  Future<void> fetchTrending() async {
    emit(TrendingLoading());
    try {
      final movies = await getTrendingMovies();
      emit(TrendingLoaded(movies));
    } catch (e) {
      emit(TrendingError(e.toString()));
    }
  }
}

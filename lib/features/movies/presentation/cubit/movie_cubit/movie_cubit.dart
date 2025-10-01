import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_movies.dart';
import 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  final GetMovies getMovies;

  // Keep categories here or inject them
  static const categories = ['now_playing', 'upcoming', 'top_rated', 'popular'];

  MovieCubit(this.getMovies) : super(MovieState.initial()) {
    // auto load first category
    fetchInitial();
  }

  String _categoryForIndex(int idx) => categories[idx.clamp(0, categories.length - 1)];

  Future<void> fetchInitial([int index = 0]) async {
    emit(state.copyWith(isLoading: true, error: null, selectedIndex: index, page: 0));
    try {
      final pageEntity = await getMovies(category: _categoryForIndex(index), page: 1);
      emit(state.copyWith(
        movies: pageEntity.results,
        page: pageEntity.page,
        totalPages: pageEntity.totalPages,
        isLoading: false,
        isFetchingMore: false,
        error: null,
        selectedIndex: index,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString(), isFetchingMore: false));
    }
  }

  Future<void> changeTab(int index) async {
    if (index == state.selectedIndex) return;
    await fetchInitial(index);
  }

  Future<void> fetchMore() async {
    if (state.isFetchingMore) return;
    if (state.page >= state.totalPages) return;
    final nextPage = state.page + 1;
    emit(state.copyWith(isFetchingMore: true));
    try {
      final pageEntity = await getMovies(category: _categoryForIndex(state.selectedIndex), page: nextPage);
      final combined = [...state.movies, ...pageEntity.results];
      emit(state.copyWith(
        movies: combined,
        page: pageEntity.page,
        totalPages: pageEntity.totalPages,
        isFetchingMore: false,
      ));
    } catch (e) {
      emit(state.copyWith(isFetchingMore: false, error: e.toString()));
    }
  }

  Future<void> refresh() async => fetchInitial(state.selectedIndex);
}

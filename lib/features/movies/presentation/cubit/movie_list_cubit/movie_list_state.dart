import 'package:equatable/equatable.dart';

import '../../../domain/entities/movie_entity.dart';

class MovieListState extends Equatable {
  final List<Movie> movies;
  final int page;
  final int totalPages;
  final bool isLoading;        // initial/refresh loading
  final bool isFetchingMore;   // pagination loading
  final String? error;
  final int selectedIndex;

  const MovieListState({
    required this.movies,
    required this.page,
    required this.totalPages,
    required this.isLoading,
    required this.isFetchingMore,
    this.error,
    required this.selectedIndex,
  });

  factory MovieListState.initial() => const MovieListState(
    movies: [],
    page: 0,
    totalPages: 1,
    isLoading: false,
    isFetchingMore: false,
    error: null,
    selectedIndex: 0,
  );

  MovieListState copyWith({
    List<Movie>? movies,
    int? page,
    int? totalPages,
    bool? isLoading,
    bool? isFetchingMore,
    String? error,
    int? selectedIndex,
  }) {
    return MovieListState(
      movies: movies ?? this.movies,
      page: page ?? this.page,
      totalPages: totalPages ?? this.totalPages,
      isLoading: isLoading ?? this.isLoading,
      isFetchingMore: isFetchingMore ?? this.isFetchingMore,
      error: error,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }

  @override
  List<Object?> get props =>
      [movies, page, totalPages, isLoading, isFetchingMore, error, selectedIndex];
}

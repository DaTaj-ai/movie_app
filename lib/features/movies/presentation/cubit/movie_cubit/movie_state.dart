import 'package:equatable/equatable.dart';

import '../../../domain/entities/movie_entity.dart';

class MovieState extends Equatable {
  final List<Movie> movies;
  final int page;
  final int totalPages;
  final bool isLoading;        // initial/refresh loading
  final bool isFetchingMore;   // pagination loading
  final String? error;
  final int selectedIndex;

  const MovieState({
    required this.movies,
    required this.page,
    required this.totalPages,
    required this.isLoading,
    required this.isFetchingMore,
    this.error,
    required this.selectedIndex,
  });

  factory MovieState.initial() => const MovieState(
    movies: [],
    page: 0,
    totalPages: 1,
    isLoading: false,
    isFetchingMore: false,
    error: null,
    selectedIndex: 0,
  );

  MovieState copyWith({
    List<Movie>? movies,
    int? page,
    int? totalPages,
    bool? isLoading,
    bool? isFetchingMore,
    String? error,
    int? selectedIndex,
  }) {
    return MovieState(
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


import 'package:equatable/equatable.dart';

import '../../../domain/entities/movie_entity.dart';

abstract class TrendingState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TrendingInitial extends TrendingState {}

class TrendingLoading extends TrendingState {}

class TrendingLoaded extends TrendingState {
  final List<Movie> movies;
  TrendingLoaded(this.movies);
  @override
  List<Object?> get props => [movies];
}

class TrendingError extends TrendingState {
  final String message;
  TrendingError(this.message);
  @override
  List<Object?> get props => [message];
}

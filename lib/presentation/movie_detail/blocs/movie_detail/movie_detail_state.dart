part of 'movie_detail_bloc.dart';

sealed class MovieDetailState extends Equatable {
  @override
  List<Object> get props => [];
}

final class MovieDetailInitial extends MovieDetailState {}

final class MovieDetailLoading extends MovieDetailState {}

final class MovieDetailLoaded extends MovieDetailState {
  final Map<String, MovieDetail> detail;

  MovieDetailLoaded({required this.detail});

  @override
  List<Object> get props => [detail];
}

final class MovieDetailError extends MovieDetailState {
  final String message;

  MovieDetailError({required this.message});

  @override
  List<Object> get props => [message];
}

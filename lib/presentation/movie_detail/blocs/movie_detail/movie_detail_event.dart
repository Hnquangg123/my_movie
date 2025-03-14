part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  // const DetailEvent();

  @override
  List<Object> get props => [];
}

class FetchMovieDetail extends MovieDetailEvent {
  final int id;

  FetchMovieDetail({required this.id});

  @override
  List<Object> get props => [id];
}

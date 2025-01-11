part of 'detail_bloc.dart';

abstract class DetailEvent extends Equatable {
  // const DetailEvent();

  @override
  List<Object> get props => [];
}

class FetchMovieDetail extends DetailEvent {
  final int id;

  FetchMovieDetail({required this.id});

  @override
  List<Object> get props => [id];
}

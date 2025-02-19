part of 'tv_detail_bloc.dart';

sealed class TvDetailEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchTvDetail extends TvDetailEvent {
  final int id;

  FetchTvDetail({required this.id});

  @override
  List<Object> get props => [id];
}

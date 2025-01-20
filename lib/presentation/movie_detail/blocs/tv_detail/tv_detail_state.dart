part of 'tv_detail_bloc.dart';

sealed class TvDetailState extends Equatable {
  @override
  List<Object> get props => [];
}

final class TvDetailInitial extends TvDetailState {}

final class TvDetailLoading extends TvDetailState {}

final class TvDetailLoaded extends TvDetailState {
  final Map<String, TvDetail> detail;

  TvDetailLoaded({required this.detail});

  @override
  List<Object> get props => [detail];
}

final class TvDetailError extends TvDetailState {
  final String message;

  TvDetailError({required this.message});

  @override
  List<Object> get props => [message];
}

part of 'detail_bloc.dart';

sealed class DetailState extends Equatable {
  @override
  List<Object> get props => [];
}

final class DetailInitial extends DetailState {}

final class DetailLoading extends DetailState {}

final class DetailLoaded extends DetailState {
  final Map<String, dynamic> detail;

  DetailLoaded({required this.detail});

  @override
  List<Object> get props => [detail];
}

final class DetailError extends DetailState {
  final String message;

  DetailError({required this.message});

  @override
  List<Object> get props => [message];
}

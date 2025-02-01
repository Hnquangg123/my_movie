part of 'search_bloc.dart';

abstract class SearchState extends Equatable {

  @override
  List<Object> get props => [];
}

final class SearchInitial extends SearchState {}

final class SearchLoading extends SearchState {}

final class SearchLoaded extends SearchState {
  final Map<String, List<dynamic>> movies;

  SearchLoaded({required this.movies});

  @override
  List<Object> get props => [movies];
}

final class SearchError extends SearchState {
  final String message;

  SearchError({required this.message});

  @override
  List<Object> get props => [message];
}

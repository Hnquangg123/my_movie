part of 'load_data_bloc.dart';

sealed class LoadDataEvent extends Equatable {
  const LoadDataEvent();

  @override
  List<Object> get props => [];
}

class LoadMoviesToDatabase extends LoadDataEvent {
  final String query;

  const LoadMoviesToDatabase({required this.query});

  @override
  List<Object> get props => [query];
}

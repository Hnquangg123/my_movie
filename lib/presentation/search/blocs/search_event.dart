part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchMovies extends SearchEvent {
  final String query;

  const SearchMovies({required this.query});

  @override
  List<Object> get props => [query];
}


class SearchMoviesEmbedding extends SearchEvent {
  final String query;

  const SearchMoviesEmbedding({required this.query});

  @override
  List<Object> get props => [query];
}

// class IntegrateMoviesToDatabase extends SearchEvent {
//   final String query;

//   const IntegrateMoviesToDatabase({required this.query});

//   @override
//   List<Object> get props => [query];
// }



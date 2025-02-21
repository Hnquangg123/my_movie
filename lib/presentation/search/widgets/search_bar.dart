import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movie/presentation/movie_detail/screens/movie_tv_detail.dart';
import 'package:my_movie/presentation/search/blocs/search_bloc.dart';

class SearchBarWidget extends StatelessWidget {
  SearchBarWidget({super.key});

  final SearchController _searchController = SearchController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SearchBloc, SearchState>(
      listener: (context, state) {
        if (state is SearchLoaded) {
          // Close the search view after results are loaded
          if (_searchController.isOpen) {
            _searchController.closeView("");
            FocusScope.of(context).unfocus();
          }
        }
      },
      child: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          List<dynamic> suggestions = [];
          return SearchAnchor.bar(
            searchController: _searchController,
            onSubmitted: (value) {
              _refreshSuggestions(_searchController);
              // _searchController.closeView(value);
              context.read<SearchBloc>().add(SearchMovies(query: value));
            },
            suggestionsBuilder: (context, controller) {
              if (state is SearchInitial) {
                suggestions = [];
              }

              if (state is SearchLoaded) {
                suggestions = state.movies['movies'] ?? [];
              }
              if (state is SearchLoading) {
                return [
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                ];
              }

              // return getSuggestions(context, controller, suggestions);

              return suggestions.map((movie) {
                return ListTile(
                  leading: Image.network(
                    movie.posterPath != ''
                        ? 'https://image.tmdb.org/t/p/w200${movie.posterPath}'
                        : 'https://dummyimage.com/500x750/cccccc/ffffff&text=No+Image',
                  ),
                  title: Text(movie.title),
                  subtitle: Text(movie.mediaType == 'movie'
                      ? movie.releaseDate
                      : movie.mediaType == 'tv'
                          ? movie.firstAirDate
                          : 'No Release Date'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieTVDetail(
                          movieTVId: movie.id,
                          mediaType: movie.mediaType,
                        ),
                      ),
                    );
                  },
                );
              }).toList();
            },
          );
        },
      ),
    );
  }

  void _refreshSuggestions(SearchController controller) {
    const String zeroWidthSpace = '\u200B';
    final previousText = controller.text;
    controller.text =
        '$zeroWidthSpace$previousText'; // This will trigger updateSuggestions and call `suggestionsBuilder`.
    controller.text = previousText;
  }

  // Iterable<Widget> getSuggestions(BuildContext context,
  //     SearchController controller, List<dynamic> suggestions) {
  //   return suggestions.map((movie) {
  //     return ListTile(
  //       leading: Image.network(
  //         movie.posterPath != ''
  //             ? 'https://image.tmdb.org/t/p/w200${movie.posterPath}'
  //             : 'https://dummyimage.com/500x750/cccccc/ffffff&text=No+Image',
  //       ),
  //       title: Text(movie.title),
  //       subtitle: Text(movie.mediaType == 'movie'
  //           ? movie.releaseDate
  //           : movie.mediaType == 'tv'
  //               ? movie.firstAirDate
  //               : 'No Release Date'),
  //       onTap: () {
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => MovieTVDetail(
  //               movieTVId: movie.id,
  //               mediaType: movie.mediaType,
  //             ),
  //           ),
  //         );
  //       },
  //     );
  //   }).toList();
  // }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movie/presentation/movie_detail/screens/movie_tv_detail.dart';
import 'package:my_movie/presentation/search/blocs/search_bloc.dart';

class SearchBarWidget extends StatelessWidget {
  SearchBarWidget({super.key});

  final searchController = SearchController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        List<dynamic> suggestions = [];

        // print(state);

        if (state is SearchInitial) {
          suggestions = [];
        }

        if (state is SearchLoading) {
          return SearchAnchor.bar(
            onSubmitted: (value) {
              context.read<SearchBloc>().add(SearchMoviesEmbedding(query: value));
            },
            suggestionsBuilder: (context, searchController) {
              return [
                Center(
                  child: CircularProgressIndicator(),
                ),
              ];
            },
          );
        }
        if (state is SearchLoaded) {
          suggestions = state.movies['enriched_movies'] ?? [];
        }

        return SearchAnchor.bar(
          onSubmitted: (value) {
            context.read<SearchBloc>().add(SearchMoviesEmbedding(query: value));
          },
          onChanged: (value) {
            // context.read<SearchBloc>().add(SearchMoviesEmbedding(query: value));
          },
          suggestionsBuilder: (context, controller) {
            return suggestions.map((movie) {
              return ListTile(
                leading: Image.network(
                  movie['poster_path'] != ''
                      ? 'https://image.tmdb.org/t/p/w200${movie['poster_path']}'
                      : 'https://dummyimage.com/500x750/cccccc/ffffff&text=No+Image',
                ),
                title: Text(movie['title']),
                subtitle: Text(movie['release_date'] ?? 'No release date'),
                
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieTVDetail(
                        movieTVId: movie['id'],
                        mediaType: movie['media_type'],
                      ),
                    ),
                  );
                },
              );
            }).toList();
          },
        );
      },
    );
  }
}

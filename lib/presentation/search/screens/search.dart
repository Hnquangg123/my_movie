import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movie/core/config/dependency_injection.dart';
import 'package:my_movie/core/util/app_colors.dart';
import 'package:my_movie/core/util/image_url.dart';
import 'package:my_movie/presentation/movie_detail/screens/movie_tv_detail.dart';
import 'package:my_movie/presentation/search/blocs/search_bloc.dart';
import 'package:my_movie/presentation/search/widgets/search_bar.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final searchBloc = getIt<SearchBloc>();
        return searchBloc;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('What would you like to watch?'),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(100.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SearchBarWidget(),
            ),
          ),
        ),
        body: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            return _buildBody(context, state);
          },
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, SearchState state) {
    if (state is SearchLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is SearchLoaded) {
      // return ListView.builder(
      //   itemCount: state.movies['enriched_movies']?.length ?? 0,
      //   itemBuilder: (context, index) {
      //     final movie = state.movies['enriched_movies']?[index];
      //     return ListTile(
      //       title: Text(movie['title']),
      //       subtitle: Text(movie['overview']),
      //     );
      //   },
      // );
      final interestedMovies = state.movies['enriched_movies'] ?? [];
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                spacing: 8,
                children: [
                  Text(
                    'You might interested',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            ConstrainedBox(
              // 0.45 for 1.3.1
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.65),
              // height: MediaQuery.of(context).size.height * 0.65,
              child: CarouselView.weighted(
                flexWeights: [1, 1, 1],
                itemSnapping: true,
                // controller: CarouselController(
                //   initialItem: 1,
                // ),
                scrollDirection: Axis.vertical,
                onTap: (index) {
                  final movies = interestedMovies[index];
                  print('Interested Movies: ${movies['title']}');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieTVDetail(
                        movieTVId: movies['id'],
                        mediaType: movies['media_type'],
                      ),
                    ),
                  );
                },
                children: List<Widget>.generate(
                  interestedMovies.length,
                  (int index) {
                    final movies = interestedMovies[index];
                    return Container(
                      margin: EdgeInsets.all(9.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.onSecondaryColor,
                            blurRadius: 16,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          movies['poster_path'] != ''
                              ? '${ImageUrl.tmdbBaseUrlW500}${movies['poster_path']}'
                              : 'https://dummyimage.com/500x750/cccccc/ffffff&text=No+Image',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Icon(
                            Icons.error,
                            size: 100,
                            color: AppColors.surfaceColor,
                          ),
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        (loadingProgress.expectedTotalBytes ??
                                            1)
                                    : null,
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      );
    } else if (state is SearchError) {
      return Center(child: Text(state.message));
    } else {
      return const Center(
          child: Text(
        'You have not searched for anything recently!',
        style: TextStyle(fontSize: 16.0),
      ));
    }
  }
}

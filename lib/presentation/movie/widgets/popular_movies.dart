import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movie/core/util/app_colors.dart';
import 'package:my_movie/core/util/image_url.dart';
import 'package:my_movie/presentation/movie/blocs/movie_bloc.dart';

class PopularMovies extends StatelessWidget {
  const PopularMovies({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {
        if (state is MovieError) {
          return Text(
            state.message,
            style: TextStyle(color: AppColors.surfaceColor),
          );
        }
        if (state is MovieLoaded) {
          final popularMovies = state.movies['popular'] ?? [];
          if (popularMovies.isEmpty) {
            return Center(
              child: Text(
                'No movies available for now!',
                style: TextStyle(color: AppColors.primaryColor),
              ),
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  spacing: 8,
                  children: [
                    Icon(
                      Icons.star,
                      color: AppColors.primaryColor,
                      size: 28,
                    ),
                    Text(
                      'Popular',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                // 0.45 for 1.3.1
                height: MediaQuery.of(context).size.height * 0.55,
                child: CarouselView.weighted(
                  flexWeights: [1, 7, 1],
                  itemSnapping: true,
                  scrollDirection: Axis.horizontal,
                  children: List<Widget>.generate(
                    popularMovies.length,
                    (int index) {
                      final movies = popularMovies[index];
                      return GestureDetector(
                        onTap: () {
                          // Handle tap event here
                        },
                        child: Container(
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
                              movies.posterPath != ''
                                  ? '${ImageUrl.tmdbBaseUrlW500}${movies.posterPath}'
                                  : 'https://dummyimage.com/500x750/cccccc/ffffff&text=No+Image',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Icon(
                                Icons.error,
                                size: 100,
                                color: AppColors.surfaceColor,
                              ),
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            (loadingProgress
                                                    .expectedTotalBytes ??
                                                1)
                                        : null,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}

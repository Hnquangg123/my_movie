import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movie/core/util/app_colors.dart';
import 'package:my_movie/core/util/image_url.dart';
import 'package:my_movie/presentation/movie/blocs/movie_bloc.dart';

class TrendingMovies extends StatelessWidget {
  const TrendingMovies({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {
        if (state is MovieLoading) {
          return CircularProgressIndicator(
            color: AppColors.onPrimaryColor,
          );
        } else if (state is MovieError) {
          return Text(
            state.message,
            style: TextStyle(color: AppColors.surfaceColor),
          );
        }
        if (state is MovieLoaded) {
          final trendingMovies = state.movies['trending'] ?? [];
          if (trendingMovies.isEmpty) {
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
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  spacing: 8,
                  children: [
                    Icon(
                      Icons.trending_up,
                      color: AppColors.primaryColor,
                      size: 28,
                    ),
                    Text(
                      'Trending',
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
                constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.65),
                // height: MediaQuery.of(context).size.height * 0.65,
                child: CarouselView.weighted(
                  flexWeights: [1, 7, 1],
                  itemSnapping: true,
                  // controller: CarouselController(
                  //   initialItem: 1,
                  // ),
                  children: List<Widget>.generate(
                    trendingMovies.length,
                    (int index) {
                      final movies = trendingMovies[index];
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
                              '${ImageUrl.tmdbBaseUrlW500}${movies.posterPath}',
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
                                            (loadingProgress.expectedTotalBytes ?? 1)
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

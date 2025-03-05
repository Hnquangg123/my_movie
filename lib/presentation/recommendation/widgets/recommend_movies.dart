import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movie/core/util/app_colors.dart';
import 'package:my_movie/core/util/image_url.dart';
import 'package:my_movie/presentation/movie_detail/screens/movie_tv_detail.dart';
import 'package:my_movie/presentation/recommendation/blocs/recommendation_bloc.dart';

class RecommendMovies extends StatelessWidget {
  const RecommendMovies({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecommendationBloc, RecommendationState>(
      builder: (context, state) {
        if (state is RecommendationError) {
          return Text(
            state.message,
            style: TextStyle(color: AppColors.surfaceColor),
          );
        }
        if (state is RecommendationLoaded) {
          final recommendMovies = state.movies;
          if (recommendMovies.isEmpty) {
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
              ConstrainedBox(
                // 0.45 for 1.3.1
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.8,
                ),
                // height: MediaQuery.of(context).size.height * 0.65,
                child: CarouselView.weighted(
                  padding: EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
                  scrollDirection: Axis.vertical,
                  flexWeights: [7, 1],
                  itemSnapping: true,
                  // controller: CarouselController(
                  //   initialItem: 1,
                  // ),
                  onTap: (index) {
                    final movies = recommendMovies[index];
                    print('Recommend Movies: ${movies.title}');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieTVDetail(
                          movieTVId: movies.id,
                          mediaType: movies.mediaType,
                        ),
                      ),
                    );
                  },
                  children: List<Widget>.generate(
                    recommendMovies.length,
                    (int index) {
                      final movies = recommendMovies[index];
                      return Container(
                        margin: EdgeInsets.all(0.0),
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
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}

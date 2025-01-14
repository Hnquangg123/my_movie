import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movie/core/util/app_colors.dart';
import 'package:my_movie/core/util/image_url.dart';
import 'package:my_movie/presentation/movie/blocs/movie_bloc.dart';

class TvSeries extends StatelessWidget {
  const TvSeries({super.key});

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
          final tvSeriesAirToday = state.movies['tv_air_today'] ?? [];
          if (tvSeriesAirToday.isEmpty) {
            return Center(
              child: Text(
                'No TV available for now!',
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
                  children: [
                    Icon(
                      Icons.movie,
                      color: AppColors.primaryColor,
                      size: 28,
                    ),
                    SizedBox(width: 8), // Add spacing between icon and text
                    Text(
                      'TV Series Air Today',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.27,
                  child: CarouselView.weighted(
                    flexWeights: [4, 4, 3],
                    itemSnapping: true,
                    scrollDirection: Axis.horizontal,
                    consumeMaxWeight: false,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    children: List<Widget>.generate(
                      tvSeriesAirToday.length,
                      (int index) {
                        final tv = tvSeriesAirToday[index];
                        return GestureDetector(
                          onTap: () {
                            // Handle tap event here
                          },
                          child: Container(
                            margin: EdgeInsets.all(0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.onSecondaryColor,
                                  blurRadius: 16,
                                  offset: Offset(0, 1),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: Image.network(
                                tv.posterPath != ''
                                    ? '${ImageUrl.tmdbBaseUrlW500}${tv.posterPath}'
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
                                      value:
                                          loadingProgress.expectedTotalBytes !=
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
              ),
            ],
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}

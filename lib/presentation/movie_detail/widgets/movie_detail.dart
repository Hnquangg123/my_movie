import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movie/core/util/app_colors.dart';
import 'package:my_movie/presentation/movie_detail/blocs/movie_detail/movie_detail_bloc.dart';
import 'package:my_movie/presentation/movie_detail/blocs/tv_detail/tv_detail_bloc.dart';

class MovieDetailWidget extends StatelessWidget {
  final String mediaType;

  const MovieDetailWidget({super.key, required this.mediaType});

  @override
  Widget build(BuildContext context) {
    return mediaType == 'movie'
        ? BlocBuilder<MovieDetailBloc, MovieDetailState>(
            builder: (context, state) {
              if (state == MovieDetailLoading()) {
                return CircularProgressIndicator();
              } else if (state is MovieDetailError) {
                return Text(state.message);
              } else if (state is MovieDetailLoaded) {
                final movieDetail = state.detail['movie_detail'];
                if (movieDetail == null) {
                  return Text(
                    'No information yet!',
                    style: TextStyle(color: AppColors.primaryColor),
                  );
                }

                final releaseYear =
                    DateTime.parse(movieDetail.releaseDate).year;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16, right: 16, top: 16),
                      child: Row(
                        spacing: 6,
                        children: [
                          Icon(
                            Icons.star,
                            color: AppColors.secondaryColor,
                            size: 28,
                          ),
                          Text(
                            movieDetail.voteAverage.toString(),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          Text(
                            '/ 10',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          Text(
                            '(${movieDetail.voteCount.toString()} reviews)',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: AppColors.onSurfaceColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                      ),
                      child: Row(
                        spacing: 8,
                        children: [
                          Flexible(
                            child: Text(
                              movieDetail.title,
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryColor,
                                shadows: [
                                  Shadow(
                                    color: Colors.black45,
                                    offset: Offset(2, 2),
                                    blurRadius: 10.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Text(
                            '($releaseYear)',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w400,
                              color: AppColors.primaryColor,
                              shadows: [
                                Shadow(
                                  color: Colors.black45,
                                  offset: Offset(2, 2),
                                  blurRadius: 10.0,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Wrap(
                        spacing: 8,
                        children: movieDetail.genres.map<Widget>((genre) {
                          return Chip(
                            label: Text(
                              genre,
                              style: TextStyle(color: AppColors.onPrimaryColor),
                            ),
                            backgroundColor: AppColors.surfaceColor,
                            shape: StadiumBorder(
                              side: BorderSide(
                                color: AppColors.primaryColor,
                                width: 2,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    Divider(
                      color: AppColors.primaryColor,
                      thickness: 1,
                      indent: 16,
                      endIndent: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Text(
                        movieDetail.tagLine,
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w300,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Text(
                        movieDetail.overview,
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ],
                );
              }
              return SizedBox.shrink();
            },
          )
        : BlocBuilder<TvDetailBloc, TvDetailState>(
            builder: (context, state) {
              if (state == TvDetailLoading()) {
                return CircularProgressIndicator();
              } else if (state is TvDetailError) {
                return Text(state.message);
              } else if (state is TvDetailLoaded) {
                final tvDetail = state.detail['tv_detail'];
                if (tvDetail == null) {
                  return Text(
                    'No information yet!',
                    style: TextStyle(color: AppColors.primaryColor),
                  );
                }

                final releaseYear =
                    DateTime.parse(tvDetail.firstAirDate).year;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16, right: 16, top: 16),
                      child: Row(
                        spacing: 6,
                        children: [
                          Icon(
                            Icons.star,
                            color: AppColors.secondaryColor,
                            size: 28,
                          ),
                          Text(
                            tvDetail.voteAverage.toString(),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          Text(
                            '/ 10',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          Text(
                            '(${tvDetail.voteCount.toString()} reviews)',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: AppColors.onSurfaceColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                      ),
                      child: Row(
                        spacing: 8,
                        children: [
                          Flexible(
                            child: Text(
                              tvDetail.name,
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryColor,
                                shadows: [
                                  Shadow(
                                    color: Colors.black45,
                                    offset: Offset(2, 2),
                                    blurRadius: 10.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Text(
                            '($releaseYear)',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w400,
                              color: AppColors.primaryColor,
                              shadows: [
                                Shadow(
                                  color: Colors.black45,
                                  offset: Offset(2, 2),
                                  blurRadius: 10.0,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Wrap(
                        spacing: 8,
                        children: tvDetail.genres.map<Widget>((genre) {
                          return Chip(
                            label: Text(
                              genre,
                              style: TextStyle(color: AppColors.onPrimaryColor),
                            ),
                            backgroundColor: AppColors.surfaceColor,
                            shape: StadiumBorder(
                              side: BorderSide(
                                color: AppColors.primaryColor,
                                width: 2,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    Divider(
                      color: AppColors.primaryColor,
                      thickness: 1,
                      indent: 16,
                      endIndent: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Text(
                        tvDetail.tagLine,
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w300,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Text(
                        tvDetail.overview,
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.primaryColor,
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

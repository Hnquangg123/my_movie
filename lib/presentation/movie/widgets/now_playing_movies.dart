import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movie/core/util/app_colors.dart';
import 'package:my_movie/core/util/image_url.dart';
import 'package:my_movie/presentation/movie/blocs/movie_bloc.dart';

class NowPlayingMovies extends StatelessWidget {
  const NowPlayingMovies({super.key});

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
          final nowPlayingMovies = state.movies['now_playing'] ?? [];
          if (nowPlayingMovies.isEmpty) {
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
                      Icons.movie,
                      color: AppColors.primaryColor,
                      size: 28,
                    ),
                    Text(
                      'Now Playing',
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
                height: MediaQuery.of(context).size.height * 0.35,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        MediaQuery.of(context).size.width > 600 ? 4 : 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: nowPlayingMovies.length,
                  itemBuilder: (context, index) {
                    final movie = nowPlayingMovies[index];
                    return GestureDetector(
                      onTap: () {
                        // *** This is where we navigate to the movie detail page ***
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => MovieDetailPage(movie: movie),
                        //   ),
                        // );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: GridTile(
                          footer: GridTileBar(
                            backgroundColor: AppColors.onSecondaryColor,
                            title: Text(
                              movie.title,
                              style: TextStyle(
                                fontSize: 12.0,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          child: Image.network(
                            '${ImageUrl.tmdbBaseUrlW500}${movie.posterPath}',
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
                      ),
                    );
                  },
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

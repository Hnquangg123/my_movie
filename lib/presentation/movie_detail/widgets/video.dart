import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movie/core/util/app_colors.dart';
import 'package:my_movie/presentation/movie_detail/blocs/video/video_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Video extends StatelessWidget {
  const Video({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideoBloc, VideoState>(
      builder: (context, videoState) {
        if (videoState is VideoLoading) {
          return CircularProgressIndicator();
        } else if (videoState is VideoLoaded) {
          final videos = videoState.video;
          if (videos.isEmpty) {
            return Text(
              'This movie has no video yet!',
              style: TextStyle(color: AppColors.primaryColor),
            );
          }
          return SizedBox(
            // height: MediaQuery.of(context).size.height * 0.3,
            child: FittedBox(
              fit: BoxFit.cover,
              child: Stack(children: [
                YoutubePlayer(
                  controller: videoState.controller,
                  aspectRatio: 16 / 9,
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: AppColors.surfaceColor,
                  progressColors: ProgressBarColors(
                    playedColor: AppColors.surfaceColor,
                    handleColor: AppColors.surfaceColor,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: IgnorePointer(
                    child: ImageFiltered(
                      imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: ShaderMask(
                        shaderCallback: (rect) {
                          return LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black,
                              Colors.black.withOpacity(0),
                            ],
                            stops: [0.2, 1],
                          ).createShader(rect);
                        },
                        blendMode: BlendMode.dstOut,
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.1,
                          color: AppColors.scaffoldBackgroundColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          );
        } else if (videoState is VideoError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 16,
              children: [
                SizedBox(height: 32),
                Text(
                  videoState.message,
                  style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 32,
                      decoration: TextDecoration.none),
                ),
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}

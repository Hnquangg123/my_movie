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
          return YoutubePlayer(
            controller: videoState.controller,
            showVideoProgressIndicator: true,
            progressIndicatorColor: AppColors.surfaceColor,
            progressColors: ProgressBarColors(
              playedColor: AppColors.surfaceColor,
              handleColor: AppColors.surfaceColor,
            ),
          );
        } else if (videoState is VideoError) {
          return Text('Failed to load video');
        } else {
          return Container();
        }
      },
    );
  }
}

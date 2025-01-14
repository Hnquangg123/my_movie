import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:my_movie/domain/movie_detail/entities/video.dart';
import 'package:my_movie/domain/movie_detail/repositories/i_video_repository.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

part 'video_event.dart';
part 'video_state.dart';

@Injectable()
class VideoBloc extends Bloc<VideoEvent, VideoState> {
  final IVideoRepository videoRepository;

  VideoBloc(this.videoRepository) : super(VideoInitial()) {
    on<FetchVideos>(_onFetchVideos);
  }

  Future<void> _onFetchVideos(
      FetchVideos event, Emitter<VideoState> emit) async {
    emit(VideoLoading());
    final result = await videoRepository.getVideos(event.id);
    result.fold(
      (failure) => emit(VideoError(message: failure.message)),
      (videos) {
        // SHOW CASE MULTI VIDEOS
        // final youtubePlayers = videos.map((video) {
        //   return YoutubePlayerController(
        //     initialVideoId: video.key,
        //     flags: YoutubePlayerFlags(
        //       autoPlay: false,
        //       mute: false,
        //     ),
        //   );
        // }).toList();

        // SHOW CASE SINGLE VIDEO
        final trailerVideo = videos.firstWhere(
          (video) => video.type == 'Trailer',
          orElse: () => videos.first,
        );

        final youtubePlayerController = YoutubePlayerController(
          initialVideoId: trailerVideo.key,
          flags: YoutubePlayerFlags(
            autoPlay: false,
            mute: false,
          ),
        );

        emit(VideoLoaded(
            video: trailerVideo, controller: youtubePlayerController));
      },
    );
  }
}

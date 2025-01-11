import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_movie/domain/movie_detail/entities/video.dart';
import 'package:my_movie/domain/movie_detail/repositories/i_video_repository.dart';

part 'video_event.dart';
part 'video_state.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  final IVideoRepository videoRepository; 
  
  VideoBloc(this.videoRepository) : super(VideoInitial()) {
    on<FetchVideos>(_onFetchVideos);
  }

  Future<void> _onFetchVideos(FetchVideos event, Emitter<VideoState> emit) async {
    emit(VideoLoading());
    final result = await videoRepository.getVideos(event.id);
    result.fold(
      (failure) => emit(VideoError(message: failure.message)),
      (videos) => emit(VideoLoaded(videos: videos)),
    );
  }
  
}

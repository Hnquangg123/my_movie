part of 'video_bloc.dart';

sealed class VideoEvent extends Equatable {
  // const VideoEvent();

  @override
  List<Object> get props => [];
}

class FetchVideos extends VideoEvent {
  final int id;
  final String mediaType;

  FetchVideos({required this.id, required this.mediaType});

  @override
  List<Object> get props => [id];
}

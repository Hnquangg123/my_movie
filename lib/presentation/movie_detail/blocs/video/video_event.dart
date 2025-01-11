part of 'video_bloc.dart';

sealed class VideoEvent extends Equatable {
  // const VideoEvent();

  @override
  List<Object> get props => [];
}

class FetchVideos extends VideoEvent {
  final int id;

  FetchVideos({required this.id});

  @override
  List<Object> get props => [id];
}

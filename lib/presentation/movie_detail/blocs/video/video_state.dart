part of 'video_bloc.dart';

sealed class VideoState extends Equatable {
  // const VideoState();
  
  @override
  List<Object> get props => [];
}

final class VideoInitial extends VideoState {}

final class VideoLoading extends VideoState {}

final class VideoLoaded extends VideoState {
  final Video video;
  final YoutubePlayerController controller;


  VideoLoaded({required this.video, required this.controller,});

  @override
  List<Object> get props => [video, controller];
}

final class VideoError extends VideoState {
  final String message;

  VideoError({required this.message});

  @override
  List<Object> get props => [message];
}

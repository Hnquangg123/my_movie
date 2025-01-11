part of 'video_bloc.dart';

sealed class VideoState extends Equatable {
  // const VideoState();
  
  @override
  List<Object> get props => [];
}

final class VideoInitial extends VideoState {}

final class VideoLoading extends VideoState {}

final class VideoLoaded extends VideoState {
  final List<Video> videos;

  VideoLoaded({required this.videos});

  @override
  List<Object> get props => [videos];
}

final class VideoError extends VideoState {
  final String message;

  VideoError({required this.message});

  @override
  List<Object> get props => [message];
}

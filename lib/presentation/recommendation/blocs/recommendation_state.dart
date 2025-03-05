part of 'recommendation_bloc.dart';

abstract class RecommendationState {}

class RecommendationInitial extends RecommendationState {}

class RecommendationLoading extends RecommendationState {}

class RecommendationLoaded extends RecommendationState {
  final List<RecommendationMovie> movies;

  RecommendationLoaded({required this.movies});
}

class RecommendationError extends RecommendationState {
  final String message;

  RecommendationError({required this.message});
}

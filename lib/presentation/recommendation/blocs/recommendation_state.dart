part of 'recommendation_bloc.dart';

sealed class RecommendationState extends Equatable {
  const RecommendationState();
  
  @override
  List<Object> get props => [];
}

final class RecommendationInitial extends RecommendationState {}

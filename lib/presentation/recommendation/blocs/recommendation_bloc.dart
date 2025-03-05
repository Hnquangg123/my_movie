import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:my_movie/domain/recommendation/entities/recommendation_movie.dart';
import 'package:my_movie/domain/recommendation/repositories/i_recommendation_repository.dart';

part 'recommendation_event.dart';
part 'recommendation_state.dart';

@Injectable()
class RecommendationBloc
    extends Bloc<RecommendationEvent, RecommendationState> {
  final IRecommendationRepository _recommendationRepository;

  RecommendationBloc(this._recommendationRepository)
      : super(RecommendationInitial()) {
    on<LoadRecommendations>(_loadRecommendation);
  }

  Future<void> _loadRecommendation(
      LoadRecommendations event, Emitter<RecommendationState> emit) async {
    emit(RecommendationLoading());

    final movies =
        await _recommendationRepository.getRecommendedMovies();

    print(movies);

    await movies.fold(
      (failure) async {
        if (!emit.isDone) {
          emit(RecommendationError(message: 'Failed to load recommendations'));
        }
      },
      (movies) async {
        emit(RecommendationLoaded(movies: movies));
      },
    );
  }
}

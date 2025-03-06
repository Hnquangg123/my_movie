import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:my_movie/core/error/failure.dart';
import 'package:my_movie/data/recommendation/services/recommendation_service.dart';
import 'package:my_movie/domain/recommendation/entities/recommendation_movie.dart';

import 'package:my_movie/domain/recommendation/repositories/i_recommendation_repository.dart';

@Injectable(as: IRecommendationRepository)
class RecommendationRepository implements IRecommendationRepository {
  final RecommendationService _recommendationServices;

  RecommendationRepository(this._recommendationServices);

  @override
  Future<Either<Failure, List<RecommendationMovie>>> getRecommendedMovies() async {
    try {
      final recommendationMovies = await _recommendationServices.getRecommendedMovies();
      return Right(recommendationMovies);
    } catch (e) {
      print(e);
      return Left(ServerFailure(message: e.toString()));
    }
  }
}

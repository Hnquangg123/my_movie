import 'package:dartz/dartz.dart';
import 'package:my_movie/core/error/failure.dart';
import 'package:my_movie/domain/recommendation/entities/recommendation_movie.dart';

abstract class IRecommendationRepository {
  Future<Either<Failure, List<RecommendationMovie>>> getRecommendedMovies();
}

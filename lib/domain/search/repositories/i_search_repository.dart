import 'package:dartz/dartz.dart';
import 'package:my_movie/core/error/failure.dart';

abstract class ISearchRepository {
  Future<Either<Failure, List<dynamic>>> searchMovies(
    String query,
  );
  Future<Either<Failure, List<double>>> generateEmbedding(String query);
  Future<Either<Failure, List<dynamic>>> filterMoviesByEmbedding(
    List<dynamic> movies,
    List<double> queryEmbedding,
  );
  double cosineSimilarity(List<double> vectorA, List<double> vectorB);

}

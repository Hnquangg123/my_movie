import 'package:dartz/dartz.dart';
import 'package:my_movie/core/error/failure.dart';

abstract class ILoadDataRepository {
  Future<Either<Failure, List<dynamic>>> getMovies(String query);
  Future<void> loadDataToSupabase(List<dynamic> movies);
}

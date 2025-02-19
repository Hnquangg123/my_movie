import 'package:dartz/dartz.dart';
import 'package:my_movie/core/error/failure.dart';
import 'package:my_movie/domain/movie_detail/entities/tv_detail.dart';

abstract class ITvDetailRepository {
  Future<Either<Failure, TvDetail>> getTvDetail(int id);
}

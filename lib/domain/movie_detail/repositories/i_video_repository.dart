import 'package:dartz/dartz.dart';
import 'package:my_movie/core/error/failure.dart';
import 'package:my_movie/domain/movie_detail/entities/video.dart';

abstract class IVideoRepository {
  Future<Either<Failure, List<Video>>> getVideosMovie(int movieId);
  Future<Either<Failure, List<Video>>> getVideosTV(int movieId);
}

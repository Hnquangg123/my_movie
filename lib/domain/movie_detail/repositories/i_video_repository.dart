import 'package:dartz/dartz.dart';
import 'package:my_movie/core/error/failure.dart';
import 'package:my_movie/domain/movie_detail/entities/video.dart';

abstract class IVideoRepository {
  Future<Either<Failure, List<Video>>> getVideos(int movieId);
}

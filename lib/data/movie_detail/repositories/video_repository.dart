import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:my_movie/core/error/failure.dart';
import 'package:my_movie/data/movie_detail/services/fetch_video_service.dart';
import 'package:my_movie/domain/movie_detail/entities/video.dart';
import 'package:my_movie/domain/movie_detail/repositories/i_video_repository.dart';

@Injectable(as: IVideoRepository)
class VideoRepository implements IVideoRepository {
  final FetchVideoService fetchVideoService;

  VideoRepository({required this.fetchVideoService});

  @override
  Future<Either<Failure, List<Video>>> getVideosMovie(int movieId) async {
    try {
      final video = await fetchVideoService.fetchVideosMovie(movieId);
      return Right(video);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Video>>> getVideosTV(int movieId) async {
    try {
      final video = await fetchVideoService.fetchVideosTV(movieId);
      return Right(video);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}

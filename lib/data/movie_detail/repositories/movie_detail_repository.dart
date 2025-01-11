import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:my_movie/core/error/failure.dart';
import 'package:my_movie/data/movie_detail/services/fetch_movie_detail_service.dart';
import 'package:my_movie/domain/movie_detail/entities/detail.dart';
import 'package:my_movie/domain/movie_detail/repositories/i_movie_detail_repository.dart';

@Injectable(as: IMovieDetailRepository)
class MovieDetailRepository implements IMovieDetailRepository {
  final FetchMovieDetailService fetchMovieDetailService;

  MovieDetailRepository({required this.fetchMovieDetailService});

  @override
  Future<Either<Failure, Detail>> getMovieDetail(int id) async {
    try {
      final movieDetail = await fetchMovieDetailService.fetchMovieDetail(id);
      return Right(movieDetail);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}

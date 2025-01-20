import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:my_movie/core/error/failure.dart';
import 'package:my_movie/data/movie_detail/services/fetch_tv_detail_service.dart';
import 'package:my_movie/domain/movie_detail/entities/tv_detail.dart';
import 'package:my_movie/domain/movie_detail/repositories/i_tv_detail_repository.dart';

@Injectable(as: ITvDetailRepository)
class TvDetailRepository implements ITvDetailRepository {
  final FetchTvDetailService fetchTvDetailService;

  TvDetailRepository({required this.fetchTvDetailService});

  @override
  Future<Either<Failure, TvDetail>> getTvDetail(int id) async {
    try {
      final tvDetail = await fetchTvDetailService.fetchTvDetail(id);
      return Right(tvDetail);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}

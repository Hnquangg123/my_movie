import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:my_movie/core/error/failure.dart';
import 'package:my_movie/data/load_data/services/open_ai_service.dart';
import 'package:my_movie/data/load_data/services/supabase_service.dart';
import 'package:my_movie/data/load_data/services/tmdb_service.dart';
import 'package:my_movie/domain/load_data/repositories/i_load_data_repository.dart';

@Injectable(as: ILoadDataRepository)
class LoadDataRepository implements ILoadDataRepository {
  final TMDBService tmdbService;
  final OpenAIService openAIService;
  final SupabaseService supabaseService;

  LoadDataRepository({
    required this.openAIService,
    required this.supabaseService,
    required this.tmdbService,
  });

  @override
  Future<Either<Failure, List<dynamic>>> getMovies(String query) async {
    try {
      final searchMovies = await tmdbService.getMovies(query);
      return Right(searchMovies);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<void> loadDataToSupabase(List<dynamic> movies) async {
    final enrichedMovies = await Future.wait(movies.map(
      (movie) async {
        final movieEmbedding = await openAIService
            .generateEmbedding(movie.title ?? movie.overview);

        return {
          'id': movie.id,
          'title': movie.title,
          'overview': movie.overview,
          'release_date': movie.releaseDate,
          'poster_path': movie.posterPath,
          'backdrop_path': '',
          'embedding': movieEmbedding,
        };
      },
    ));

    await supabaseService.insertMovies(enrichedMovies);
  }
}

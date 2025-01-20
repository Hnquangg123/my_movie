import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:my_movie/domain/movie_detail/entities/movie_detail.dart';
import 'package:my_movie/domain/movie_detail/repositories/i_movie_detail_repository.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

@Injectable()
class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final IMovieDetailRepository movieDetailRepository;

  MovieDetailBloc(this.movieDetailRepository) : super(MovieDetailInitial()) {
    on<FetchMovieDetail>(_onFetchMovieDetail);
  }

  Future<void> _onFetchMovieDetail(
      FetchMovieDetail event, Emitter<MovieDetailState> emit) async {
    emit(MovieDetailLoading());
    final result = await movieDetailRepository.getMovieDetail(event.id);
    result.fold(
      (failure) => emit(MovieDetailError(message: failure.message)),
      (movieDetail) => emit(MovieDetailLoaded(detail: {'movie_detail': movieDetail})),
    );
  }
}

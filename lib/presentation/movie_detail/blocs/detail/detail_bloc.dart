import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:my_movie/domain/movie_detail/repositories/i_movie_detail_repository.dart';

part 'detail_event.dart';
part 'detail_state.dart';

@Injectable()
class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final IMovieDetailRepository movieDetailRepository;

  DetailBloc(this.movieDetailRepository) : super(DetailInitial()) {
    on<FetchMovieDetail>(_onFetchMovieDetail);
  }

  Future<void> _onFetchMovieDetail(
      FetchMovieDetail event, Emitter<DetailState> emit) async {
    emit(DetailLoading());
    final result = await movieDetailRepository.getMovieDetail(event.id);
    result.fold(
      (failure) => emit(DetailError(message: failure.message)),
      (movieDetail) => emit(DetailLoaded(detail: {'movie_detail': movieDetail})),
    );
  }
}

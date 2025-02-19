import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:my_movie/domain/movie_detail/entities/tv_detail.dart';
import 'package:my_movie/domain/movie_detail/repositories/i_tv_detail_repository.dart';

part 'tv_detail_event.dart';
part 'tv_detail_state.dart';

@Injectable()
class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  final ITvDetailRepository tvDetailRepository;

  TvDetailBloc(this.tvDetailRepository) : super(TvDetailInitial()) {
    on<FetchTvDetail>(_onFetchTvDetail);
  }

  Future<void> _onFetchTvDetail(
      FetchTvDetail event, Emitter<TvDetailState> emit) async {
    emit(TvDetailLoading());
    final result = await tvDetailRepository.getTvDetail(event.id);
    result.fold(
      (failure) => emit(TvDetailError(message: failure.message)),
      (tvDetail) =>
          emit(TvDetailLoaded(detail: {'tv_detail': tvDetail})),
    );
  }
}

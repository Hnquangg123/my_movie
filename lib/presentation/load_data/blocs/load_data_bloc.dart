import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:my_movie/domain/load_data/repositories/i_load_data_repository.dart';

part 'load_data_event.dart';
part 'load_data_state.dart';

@Injectable()
class LoadDataBloc extends Bloc<LoadDataEvent, LoadDataState> {
  LoadDataBloc(super.initialState);
  // final ILoadDataRepository _loadDataRepository;

  // LoadDataBloc(this._loadDataRepository) : super(LoadDataInitial()) {
  //   on<LoadMoviesToDatabase>(_loadMoviesToDatabase);
  // }

  // Future<void> _loadMoviesToDatabase(
  //     LoadMoviesToDatabase event, Emitter<LoadDataState> emit) async {
  //   try {
  //     final getMovies = await _loadDataRepository.getMovies(event.query);

  //     print('I have come here');

  //     await searchMovies.fold(
  //       (failure) async {
  //         // Handle failure
  //       },
  //       (movies) async {
  //         await _loadDataRepository.insertMoviesToDatabase(movies);
  //       },
  //     );
  //   } catch (e) {
  //     emit(SearchError(message: 'Failed to init'));
  //   }
  // }
}

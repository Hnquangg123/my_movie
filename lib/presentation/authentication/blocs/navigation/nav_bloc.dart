import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'nav_event.dart';
part 'nav_state.dart';

@Injectable()
class NavBloc extends Bloc<NavEvent, NavState> {
  NavBloc() : super(NavInitial()) {
    on<NavigateHomePage>(_onNavigateHomePage);
    on<NavigateProfilePage>(_onNavigateProfilePage);
    on<NavigateSearchPage>(_onNavigateSearchPage);
  }

  Future<void> _onNavigateHomePage(
      NavigateHomePage event, Emitter<NavState> emit) async {
    emit(HomePage());
  }

  Future<void> _onNavigateProfilePage(
      NavigateProfilePage event, Emitter<NavState> emit) async {
    emit(Profile());
  }

  Future<void> _onNavigateSearchPage(
      NavigateSearchPage event, Emitter<NavState> emit) async {
    emit(Search());
  }
}

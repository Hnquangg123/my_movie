// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:my_movie/core/config/app_module.dart' as _i479;
import 'package:my_movie/data/authentication/repositories/authentication_repository.dart'
    as _i249;
import 'package:my_movie/data/movie/repositories/movie_repository.dart'
    as _i725;
import 'package:my_movie/data/movie/services/fetch_movie_service.dart' as _i471;
import 'package:my_movie/domain/authentication/repositories/i_authentication_repository.dart'
    as _i437;
import 'package:my_movie/domain/movie/repositories/i_movie_repository.dart'
    as _i1044;
import 'package:my_movie/presentation/authentication/blocs/auth_bloc.dart'
    as _i786;
import 'package:my_movie/presentation/login/blocs/login_bloc.dart' as _i942;
import 'package:my_movie/presentation/movie/blocs/movie_bloc.dart' as _i585;
import 'package:my_movie/presentation/registration/blocs/registration_bloc.dart'
    as _i280;
import 'package:supabase_flutter/supabase_flutter.dart' as _i454;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    gh.factory<_i454.GoTrueClient>(() => appModule.supabaseAuth);
    gh.factory<_i1044.IMovieRepository>(() => _i725.MovieRepository(
        fetchMovieService: gh<_i471.FetchMovieService>()));
    gh.factory<_i585.MovieBloc>(
        () => _i585.MovieBloc(gh<_i1044.IMovieRepository>()));
    gh.factory<_i437.IAuthenticationRepository>(
        () => _i249.AuthenticationRepository(gh<_i454.GoTrueClient>()));
    gh.factory<_i786.AuthBloc>(
        () => _i786.AuthBloc(gh<_i437.IAuthenticationRepository>()));
    gh.factory<_i942.LoginBloc>(
        () => _i942.LoginBloc(gh<_i437.IAuthenticationRepository>()));
    gh.factory<_i280.RegistrationBloc>(
        () => _i280.RegistrationBloc(gh<_i437.IAuthenticationRepository>()));
    return this;
  }
}

class _$AppModule extends _i479.AppModule {}

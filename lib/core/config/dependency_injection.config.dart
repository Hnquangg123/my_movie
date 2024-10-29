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
import 'package:my_movie/domain/authentication/repositories/i_authentication_repository.dart'
    as _i437;
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
    gh.factory<_i437.IAuthenticationRepository>(
        () => _i249.AuthenticationRepository(gh<_i454.GoTrueClient>()));
    return this;
  }
}

class _$AppModule extends _i479.AppModule {}

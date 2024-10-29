import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:my_movie/core/config/dependency_injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() => getIt.init();

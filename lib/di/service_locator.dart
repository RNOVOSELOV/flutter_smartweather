import 'package:get_it/get_it.dart';
import 'package:weather/data/geolocation/geo.dart';
import 'package:weather/data/http/dio_builder.dart';
import 'package:weather/data/http/owm_api/owm_api_service.dart';

final sl = GetIt.instance;

void initServiceLocator() {
  _setupDataProviders();
  _setupRepositories();
  _setupApiRelatesClasses();
  _setupBlocks();
}

// ONLY SINGLETONS
void _setupDataProviders() {
  sl.registerLazySingleton(() => Geo());
}

// ONLY SINGLETONS
void _setupRepositories() {}

void _setupApiRelatesClasses() {
  sl.registerFactory(() => DioBuilder());
  sl.registerLazySingleton(
      () => OwmApiService(sl.get<DioBuilder>().addHeaderParameters().build()));
}

// ONLY FACTORIES
void _setupBlocks() {}

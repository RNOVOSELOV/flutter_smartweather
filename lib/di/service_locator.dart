import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:weather/data/geolocation/geo.dart';
import 'package:weather/data/geolocation/geo_repository.dart';
import 'package:weather/data/http/dio_builder.dart';
import 'package:weather/data/http/owm_api/api_data_provider.dart';
import 'package:weather/data/http/owm_api/owm_api_service.dart';
import 'package:weather/data/http/repositories/api_repository.dart';
import 'package:weather/data/storage/local_data_provider.dart';
import 'package:weather/data/storage/repositories/location_repository.dart';
import 'package:weather/data/storage/shared_preference_data.dart';
import 'package:weather/presentation/login/bloc/login_bloc.dart';
import 'package:weather/presentation/weather/bloc/weather_bloc.dart';
import 'package:weather/simple_bloc_observer.dart';

final sl = GetIt.instance;

void initServiceLocator() {
  _setupDataProviders();
  _setupApiRelatesClasses();
  _setupRepositories();
  _setupBlocks();
}

// ONLY SINGLETONS
void _setupDataProviders() {
  sl.registerLazySingleton(() => Geo());
  sl.registerLazySingleton(() => SharedPreferenceData());
  sl.registerLazySingleton<LocalDataProvider>(
    () => sl.get<SharedPreferenceData>(),
  );
}

void _setupApiRelatesClasses() {
  sl.registerFactory(() => DioBuilder());
  sl.registerLazySingleton<ApiDataProvider>(
      () => OwmApiService(sl.get<DioBuilder>().addHeaderParameters().build()));
}

// ONLY SINGLETONS
void _setupRepositories() {
  sl.registerLazySingleton(
    () => LocationRepository(sl.get<LocalDataProvider>()),
  );
  sl.registerLazySingleton(() => ApiRepository(sl.get<ApiDataProvider>()));
  sl.registerLazySingleton(() => GeoRepository(geo: sl.get<Geo>()));
}

// ONLY FACTORIES
void _setupBlocks() {
  Bloc.observer = SimpleBlocObserver();
  sl.registerFactory(() => LoginBloc(
        geoRepository: sl.get<GeoRepository>(),
        apiDataRepository: sl.get<ApiRepository>(),
        locationDataRepository: sl.get<LocationRepository>(),
      ));
  sl.registerFactory(() => WeatherBloc(
        geoRepository: sl.get<GeoRepository>(),
        apiDataRepository: sl.get<ApiRepository>(),
        locationDataRepository: sl.get<LocationRepository>(),
      ));
}

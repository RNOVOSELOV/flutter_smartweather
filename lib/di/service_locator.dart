import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:weather/data/geolocation/geo.dart';
import 'package:weather/data/http/dio_builder.dart';
import 'package:weather/data/http/owm_api/owm_api_service.dart';
import 'package:weather/data/storage/local_data_provider.dart';
import 'package:weather/data/storage/repositories/location_repository.dart';
import 'package:weather/data/storage/shared_preference_data.dart';
import 'package:weather/presentation/weather/block/weather_bloc.dart';
import 'package:weather/simple_bloc_observer.dart';

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
  sl.registerLazySingleton(() => SharedPreferenceData());
  sl.registerLazySingleton<LocalDataProvider>(
    () => sl.get<SharedPreferenceData>(),
  );
}

// ONLY SINGLETONS
void _setupRepositories() {
  sl.registerLazySingleton(
    () => LocationRepository(sl.get<LocalDataProvider>()),
  );
}

void _setupApiRelatesClasses() {
  sl.registerFactory(() => DioBuilder());
  sl.registerLazySingleton(
      () => OwmApiService(sl.get<DioBuilder>().addHeaderParameters().build()));
}

// ONLY FACTORIES
void _setupBlocks() {
  if (kDebugMode) {
    Bloc.observer = SimpleBlocObserver();
  }
  sl.registerFactory(() => WeatherBloc(
        geolocationService: sl.get<Geo>(),
        apiService: sl.get<OwmApiService>(),
        dataService: sl.get<LocalDataProvider>(),
      ));
}

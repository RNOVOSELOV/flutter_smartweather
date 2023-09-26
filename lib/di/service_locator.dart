import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:weather/data/geolocation/geo.dart';
import 'package:weather/data/geolocation/geo_repository.dart';
import 'package:weather/data/http/dio_builder.dart';
import 'package:weather/data/http/owm_api/api_data_provider.dart';
import 'package:weather/data/http/owm_api/owm_api_service.dart';
import 'package:weather/data/http/repositories/api_repository.dart';
import 'package:weather/data/storage/favorites_data_provider.dart';
import 'package:weather/data/storage/local_data_provider.dart';
import 'package:weather/data/storage/repositories/favorite_repository.dart';
import 'package:weather/data/storage/repositories/location_repository.dart';
import 'package:weather/data/storage/shared_preference_data.dart';
import 'package:weather/presentation/add/bloc/add_bloc.dart';
import 'package:weather/presentation/login/bloc/login_bloc.dart';
import 'package:weather/presentation/places/bloc/places_bloc.dart';
import 'package:weather/presentation/splash/splash_bloc.dart';
import 'package:weather/presentation/weather/bloc/weather_bloc.dart';

final sl = GetIt.instance;

void initServiceLocator() {
  _setupTalkerLogger();
  _setupDataProviders();
  _setupApiRelatesClasses();
  _setupRepositories();
  _setupBlocks();
}

void _setupTalkerLogger() {
  sl.registerLazySingleton(() => TalkerFlutter.init());
  Bloc.observer = TalkerBlocObserver(talker: sl.get<Talker>());
}

// ONLY SINGLETONS
void _setupDataProviders() {
  sl.registerLazySingleton(() => Geo());
  sl.registerLazySingleton(() => SharedPreferenceData());
  sl.registerLazySingleton<LocalDataProvider>(
    () => sl.get<SharedPreferenceData>(),
  );
  sl.registerLazySingleton<FavoriteDataProvider>(
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
    () => LocalWeatherStorageRepository(sl.get<LocalDataProvider>()),
  );
  sl.registerLazySingleton(
    () => FavoriteWeatherRepository(sl.get<FavoriteDataProvider>()),
  );
  sl.registerLazySingleton(() => ApiRepository(sl.get<ApiDataProvider>()));
  sl.registerLazySingleton(() => GeoRepository(geo: sl.get<Geo>()));
}

// ONLY FACTORIES
void _setupBlocks() {
  sl.registerFactory(
    () => SplashBloc(
      storageWeatherDataRepository: sl.get<LocalWeatherStorageRepository>(),
      apiDataRepository: sl.get<ApiRepository>(),
      talker: sl.get<Talker>(),
    ),
  );
  sl.registerFactory(() => LoginBloc(
        geoRepository: sl.get<GeoRepository>(),
        apiDataRepository: sl.get<ApiRepository>(),
        locationDataRepository: sl.get<LocalWeatherStorageRepository>(),
      ));
  sl.registerFactory(() => WeatherBloc(
        talker: sl.get<Talker>(),
        geoRepository: sl.get<GeoRepository>(),
        apiDataRepository: sl.get<ApiRepository>(),
        currentLocationWeatherRepository:
            sl.get<LocalWeatherStorageRepository>(),
      ));
  sl.registerFactory(() => AddBloc(geoRepository: sl.get<GeoRepository>()));
  sl.registerFactory(() => PlacesBloc(
        talker: sl.get<Talker>(),
        apiDataRepository: sl.get<ApiRepository>(),
        currentLocationWeatherRepository:
            sl.get<LocalWeatherStorageRepository>(),
        favoriteRepository: sl.get<FavoriteWeatherRepository>(),
      ));
}

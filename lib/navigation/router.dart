import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:weather/data/dto/favorite_data_dto.dart';
import 'package:weather/data/dto/location_dto.dart';
import 'package:weather/presentation/add/add_page.dart';
import 'package:weather/presentation/places/places_page.dart';
import 'package:weather/presentation/splash/splash_page.dart';
import 'package:weather/presentation/weather/weather_page.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: SplashRoute.page,
          path: '/splash',
          initial: true,
        ),
        AutoRoute(
          page: WeatherRoute.page,
          path: '/weather',
        ),
        AutoRoute(
          page: AddNewLocationRoute.page,
          path: '/add',
        ),
        AutoRoute(
          page: PlacesRoute.page,
          path: '/places',
        )
      ];
}

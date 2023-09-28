// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AddNewLocationRoute.name: (routeData) {
      final args = routeData.argsAs<AddNewLocationRouteArgs>(
          orElse: () => const AddNewLocationRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AddNewLocationPage(
          key: args.key,
          location: args.location,
        ),
      );
    },
    SplashRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SplashPage(),
      );
    },
    WeatherRoute.name: (routeData) {
      final args = routeData.argsAs<WeatherRouteArgs>(
          orElse: () => const WeatherRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WeatherPage(
          key: args.key,
          locationData: args.locationData,
        ),
      );
    },
    PlacesRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const PlacesPage(),
      );
    },
  };
}

/// generated route for
/// [AddNewLocationPage]
class AddNewLocationRoute extends PageRouteInfo<AddNewLocationRouteArgs> {
  AddNewLocationRoute({
    Key? key,
    LocationDto? location,
    List<PageRouteInfo>? children,
  }) : super(
          AddNewLocationRoute.name,
          args: AddNewLocationRouteArgs(
            key: key,
            location: location,
          ),
          initialChildren: children,
        );

  static const String name = 'AddNewLocationRoute';

  static const PageInfo<AddNewLocationRouteArgs> page =
      PageInfo<AddNewLocationRouteArgs>(name);
}

class AddNewLocationRouteArgs {
  const AddNewLocationRouteArgs({
    this.key,
    this.location,
  });

  final Key? key;

  final LocationDto? location;

  @override
  String toString() {
    return 'AddNewLocationRouteArgs{key: $key, location: $location}';
  }
}

/// generated route for
/// [SplashPage]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [WeatherPage]
class WeatherRoute extends PageRouteInfo<WeatherRouteArgs> {
  WeatherRoute({
    Key? key,
    FavoriteDataDto? locationData,
    List<PageRouteInfo>? children,
  }) : super(
          WeatherRoute.name,
          args: WeatherRouteArgs(
            key: key,
            locationData: locationData,
          ),
          initialChildren: children,
        );

  static const String name = 'WeatherRoute';

  static const PageInfo<WeatherRouteArgs> page =
      PageInfo<WeatherRouteArgs>(name);
}

class WeatherRouteArgs {
  const WeatherRouteArgs({
    this.key,
    this.locationData,
  });

  final Key? key;

  final FavoriteDataDto? locationData;

  @override
  String toString() {
    return 'WeatherRouteArgs{key: $key, locationData: $locationData}';
  }
}

/// generated route for
/// [PlacesPage]
class PlacesRoute extends PageRouteInfo<void> {
  const PlacesRoute({List<PageRouteInfo>? children})
      : super(
          PlacesRoute.name,
          initialChildren: children,
        );

  static const String name = 'PlacesRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

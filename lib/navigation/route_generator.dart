import 'package:flutter/material.dart';
import 'package:weather/navigation/route_name.dart';
import 'package:weather/presentation/splash/splash_page.dart';

RouteFactory generateRoute() {
  return (setting) {
    final name = setting.name;
    if (name == null || name.isEmpty) {
      return MaterialPageRoute(builder: (_) => const SplashPage());
    }
    final routeName = RouteName.find(name);
    if (routeName == null) {
      return MaterialPageRoute(builder: (_) => const SplashPage());
    }
    switch (routeName) {
      case RouteName.splash:
        return _createPageRoute(const SplashPage(), routeName);
      case RouteName.login:
        // TODO: Handle this case.
        break;
      case RouteName.weather:
        // TODO: Handle this case.
        break;
    }
  };
}

Route _createPageRoute(Widget page, RouteName routeName) {
  return MaterialPageRoute(
    builder: (_) => page,
    settings: RouteSettings(name: routeName.name),
  );
}

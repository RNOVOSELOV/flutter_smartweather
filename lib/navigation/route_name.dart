import 'package:collection/collection.dart';

enum RouteName {
  splash(route: '/'),
//  splash(route: '/splash'),
  login(route: '/login'),
  weather(route: '/weather'),
//  add (route: '/');
  add (route: '/add');

  static RouteName? find(String? name) =>
      values.firstWhereOrNull((routeName) => routeName.route == name);

  final String route;

  const RouteName({required this.route});
}

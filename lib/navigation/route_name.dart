import 'package:collection/collection.dart';

enum RouteName {
  splash(route: '/'),
  login(route: '/login'),
  weather(route: '/weather');

  static RouteName? find(String? name) =>
      values.firstWhereOrNull((routeName) => routeName.route == name);

  final String route;

  const RouteName({required this.route});
}

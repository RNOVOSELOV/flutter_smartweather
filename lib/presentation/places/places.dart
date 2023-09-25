import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/di/service_locator.dart';
import 'package:weather/presentation/places/bloc/places_bloc.dart';

@RoutePage()
class PlacesPage extends StatelessWidget {
  const PlacesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl.get<PlacesBloc>()..add(const PlacesPageLoaded()),
      child: const _PlacesWidget(),
    );
  }
}

class _PlacesWidget extends StatelessWidget {
  const _PlacesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

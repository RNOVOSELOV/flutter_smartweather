import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/data/dto/location_dto.dart';
import 'package:weather/di/service_locator.dart';
import 'package:weather/navigation/router.dart';
import 'package:weather/presentation/places/bloc/places_bloc.dart';
import 'package:weather/resources/app_colors.dart';
import 'package:weather/theme/theme_extensions.dart';

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
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.backgroundTopGradientColor,
                  AppColors.backgroundEndGradientColor
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          CustomScrollView(
            slivers: [
              SliverAppBar(
                primary: true,
                stretch: true,
                pinned: false,
                floating: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                centerTitle: true,
                foregroundColor: AppColors.whiteColor,
                title: const Text('Избранное'),
                actions: [
                  BlocBuilder<PlacesBloc, PlacesState>(
                    builder: (context, state) {
                      if (state is PlacesDataState) {
                        return GestureDetector(
                          onTap: () async {
                            final bloc = context.read<PlacesBloc>();
                            final result =
                                await context.router.push(AddNewLocationRoute(
                                    location: LocationDto(
                              location: state.currentPlace.location,
                              latitude: state.currentPlace.latitude,
                              longitude: state.currentPlace.longitude,
                            )));
                            bloc.add(PlacesAddNewFavoritesLocation(
                                locationDto: result as LocationDto));
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Icon(
                              Icons.add,
                              color: AppColors.textWhiteColor,
                            ),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 12,
                ),
              ),
              BlocBuilder<PlacesBloc, PlacesState>(
                builder: (context, state) {
                  if (state is PlacesDataState) {
                    final favorites = state.favorites;
                    return SliverList.separated(
                      itemCount: 1 + 1 + favorites.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(height: 8);
                      },
                      itemBuilder: (BuildContext context, int index) {
                        if (index == 0) {
                          return GestureDetector(
                            onTap: () => context.router.pop(),
                            child: _PlaceWeatherContainer(
                                placeName: state.currentPlace.location,
                                temperature: state.currentPlace.temperature,
                                icon: state.currentPlace.icon,
                                isCurrentPlace: true),
                          );
                        } else if (index == 1) {
                          return favorites.isEmpty
                              ? const SizedBox.shrink()
                              : Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const SizedBox(height: 12),
                                    Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 32),
                                        width: double.infinity,
                                        child: Text(
                                          'Сохраненные местоположения',
                                          textAlign: TextAlign.left,
                                          style: context.theme.b2.copyWith(
                                              color: AppColors.whiteColor
                                                  .withAlpha(210)),
                                        )),
                                  ],
                                );
                        } else {
                          return GestureDetector(
                            onTap: () {
                              context.router
                                  .pop(favorites.elementAt(index - 2));
                            },
                            child: _PlaceWeatherContainer(
                              placeName:
                                  favorites.elementAt(index - 2).location,
                              temperature:
                                  favorites.elementAt(index - 2).temperature,
                              icon: favorites.elementAt(index - 2).icon,
                              isCurrentPlace: false,
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    );
                  }
                  return const SliverToBoxAdapter(child: SizedBox.shrink());
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PlaceWeatherContainer extends StatelessWidget {
  const _PlaceWeatherContainer({
    Key? key,
    required this.isCurrentPlace,
    required this.placeName,
    required this.temperature,
    required this.icon,
  }) : super(key: key);

  final bool isCurrentPlace;
  final String placeName;
  final int temperature;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.coolGreyColor,
        shape: BoxShape.rectangle,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: Border.all(
          color: AppColors.whiteColor.withAlpha(50),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isCurrentPlace)
                  Text(
                    'Текущее местоположение',
                    style: context.theme.b3
                        .copyWith(color: AppColors.whiteColor.withAlpha(210)),
                  ),
                if (isCurrentPlace) const SizedBox(height: 8),
                Text(
                  placeName,
                  overflow: TextOverflow.ellipsis,
                  style: context.theme.h2,
                ),
              ],
            ),
          ),
          const SizedBox(width: 4),
          Text(
            '$temperatureº',
            style: GoogleFonts.ubuntu(
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w500,
                fontSize: 24,
                height: 28 / 24,
                color: AppColors.textWhiteColor),
          ),
          CachedNetworkImage(
            placeholder: (context, url) => Row(
              children: [
                const SizedBox(width: 4),
                Container(
                  height: 64,
                  width: 64,
                  padding: const EdgeInsets.all(12),
                  child: const CircularProgressIndicator(
                    color: AppColors.lightPink,
                  ),
                ),
              ],
            ),
            imageUrl: icon, //'https://openweathermap.org/img/wn/10d@2x.png',
            imageBuilder: (context, imageProvider) => Row(
              children: [
                const SizedBox(width: 4),
                Image(
                  image: imageProvider,
                  width: 64,
                  height: 64,
                  fit: BoxFit.fill,
                ),
              ],
            ),
            errorWidget: (context, url, error) => const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

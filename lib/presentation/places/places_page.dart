import 'package:auto_route/annotations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/di/service_locator.dart';
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
              const SliverAppBar(
                primary: true,
                stretch: true,
                pinned: true,
                floating: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                centerTitle: true,
                foregroundColor: AppColors.whiteColor,
                title: Text('Избранное'),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 12,
                ),
              ),
              SliverList.separated(
                itemCount: 2,
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 8);
                },
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return const _PlaceWeatherContainer(isCurrentPlace: true);
                  } else if (index == 1) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 12),
                        Container(
                            margin: const EdgeInsets.symmetric(horizontal: 32),
                            width: double.infinity,
                            child: Text(
                              'Сохраненные местоположения',
                              textAlign: TextAlign.left,
                              style: context.theme.b2.copyWith(
                                  color: AppColors.whiteColor.withAlpha(180)),
                            )),
                      ],
                    );
                  }
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
  }) : super(key: key);

  final bool isCurrentPlace;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.backgroundCardColor,
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isCurrentPlace)
                Text(
                  'Текущее местоположение',
                  style: context.theme.b3
                      .copyWith(color: AppColors.whiteColor.withAlpha(180)),
                ),
              if (isCurrentPlace) const SizedBox(height: 8),
              Text(
                'Nizhny Novgorod',
                style: context.theme.h2,
              ),
            ],
          ),
          const Spacer(),
          Text(
            '23º',
            style: GoogleFonts.ubuntu(
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w500,
                fontSize: 32,
                height: 36 / 32,
                color: AppColors.textWhiteColor),
          ),
          CachedNetworkImage(
            placeholder: (context, url) => Row(
              children: [
                const SizedBox(width: 12),
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
            imageUrl: 'https://openweathermap.org/img/wn/10d@2x.png',
            imageBuilder: (context, imageProvider) => Row(
              children: [
                const SizedBox(width: 12),
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

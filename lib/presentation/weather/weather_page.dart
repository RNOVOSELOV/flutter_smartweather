import 'package:css_filter/css_filter.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/data/dto/location_dto.dart';
import 'package:weather/data/dto/location_weather_dto.dart';
import 'package:weather/data/dto/weather_additional_dto.dart';
import 'package:weather/data/dto/weather_dto.dart';
import 'package:weather/di/service_locator.dart';
import 'package:weather/presentation/weather/block/weather_bloc.dart';
import 'package:weather/data/dto/parameter_dto.dart';
import 'package:weather/resources/app_colors.dart';
import 'package:weather/resources/app_images.dart';
import 'package:weather/resources/app_strings.dart';
import 'package:weather/theme/theme_extensions.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl.get<WeatherBloc>()..add(const WeatherPageLoaded()),
      child: const _WeatherPageWidget(),
    );
  }
}

class _WeatherPageWidget extends StatelessWidget {
  const _WeatherPageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
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
        child: const _WeatherWidget(),
      ),
    );
  }
}

class _WeatherWidget extends StatefulWidget {
  const _WeatherWidget({Key? key}) : super(key: key);

  @override
  State<_WeatherWidget> createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<_WeatherWidget> {
  @override
  Widget build(BuildContext context) {
    bool inProgress = true;
    LocationDto? locationData;
    WeatherDto? weatherData;
    WeatherAdditionalDto? additionalWeatherData;
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is WeatherInitialState ||
            state is WeatherStartLongOperationState) {
          inProgress = true;
        } else if (state is WeatherEndLongOperationState) {
          inProgress = false;
        } else if (state is WeatherNewDataState) {
          locationData = state.data.location;
          weatherData = state.data.weather;
          additionalWeatherData = state.data.additionalWeather;
        }

        return Stack(
          children: [
            CSSFilter.blur(
              child: CustomScrollView(
                slivers: [
                  _AppBarWidget(
                      location:
                          locationData != null ? locationData!.location : ''),
                  _MainWeatherInfoWidget(weather: weatherData),
                  _DayWeatherInfoWidget(),
                  _AdditionalWeatherInfoWidget(data: additionalWeatherData),
                ],
              ),
              value: inProgress ? 2 : 0,
            ),
            if (inProgress)
              const Center(
                child: CircularProgressIndicator(
                  color: AppColors.lightPink,
                ),
              ),
            if (inProgress)
              ListView(physics: const NeverScrollableScrollPhysics()),
          ],
        );
      },
    );
  }
}

class _AppBarWidget extends StatelessWidget {
  const _AppBarWidget({Key? key, required this.location}) : super(key: key);

  final String location;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      toolbarHeight: 56,
      primary: true,
      stretch: true,
      pinned: false,
      elevation: 0,
      expandedHeight: 272,
      excludeHeaderSemantics: true,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        stretchModes: const [
          StretchMode.blurBackground,
          StretchMode.zoomBackground
        ],
        background: SafeArea(
          child: Column(
            children: [
              _LocationBar(location: location),
              const Spacer(),
              Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: CSSFilter.blur(
                      child: Container(
                        height: 150,
                        width: 150,
                        margin: const EdgeInsets.only(bottom: 30),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.backgroundBlurColor,
                        ),
                      ),
                      value: 30,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Image.asset(
                      AppImages.bigIconSun,
                      height: 180,
                      width: 180,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _LocationBar extends StatelessWidget {
  const _LocationBar({Key? key, required this.location}) : super(key: key);

  final String location;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      color: Colors.transparent,
      alignment: Alignment.centerLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 28),
          SvgPicture.asset(
            AppImages.iconLocation,
            width: 16,
          ),
          const SizedBox(width: 12),
          Text(location,
              style: GoogleFonts.roboto(
                textStyle: context.theme.b2,
                fontWeight: FontWeight.w500,
              )),
        ],
      ),
    );
  }
}

class _MainWeatherInfoWidget extends StatelessWidget {
  const _MainWeatherInfoWidget({Key? key, required this.weather})
      : super(key: key);

  final WeatherDto? weather;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            weather != null ? '${weather!.temperature}º' : '',
            style: GoogleFonts.ubuntu(
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w500,
                fontSize: 64,
                height: 72 / 64,
                color: AppColors.textWhiteColor),
          ),
          Text(
            weather != null ? weather!.description : '',
            style: context.theme.b1,
          ),
          const SizedBox(height: 8),
          Text(
            weather != null
                ? '${AppStrings.maxTemperatureString} ${weather!.temperatureMax}º ${AppStrings.minTemperatureString} ${weather!.temperatureMin}º'
                : '',
            style: context.theme.b1,
          ),
        ],
      ),
    );
  }
}

class _DayWeatherInfoWidget extends StatelessWidget {
  const _DayWeatherInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: AppColors.backgroundCardColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.currentDayString,
                    style: GoogleFonts.roboto(
                      textStyle: context.theme.b1,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '20 марта',
                    style: GoogleFonts.roboto(
                      textStyle: context.theme.b2,
                      color: AppColors.textDateColor,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              color: AppColors.dividerColor,
              thickness: 1,
              height: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                height: 142,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      width: 74,
                      decoration: index != 1
                          ? null
                          : BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12)),
                              shape: BoxShape.rectangle,
                              color: AppColors.backgroundActiveCartColor,
                              border: Border.all(
                                  width: 1,
                                  color: AppColors.activeCartBorderColor),
                            ),
                      child: const _CartInDayListWidget(),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CartInDayListWidget extends StatelessWidget {
  const _CartInDayListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 16),
        Text(
          '15:00',
          style: context.theme.b2,
        ),
        const SizedBox(height: 16),
        Image.asset(
          AppImages.iconCloudLightning,
          height: 32,
          width: 32,
        ),
        const SizedBox(height: 16),
        Text(
          '23º',
          style: GoogleFonts.roboto(
            textStyle: context.theme.b1,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _AdditionalWeatherInfoWidget extends StatelessWidget {
  const _AdditionalWeatherInfoWidget({Key? key, this.data}) : super(key: key);

  final WeatherAdditionalDto? data;

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return const SliverToBoxAdapter(
        child: SizedBox.shrink(),
      );
    }
    final list = data!.toParametersList();
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.only(left: 24, right: 24, bottom: 38),
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: AppColors.backgroundCardColor,
        ),
        child: ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    list.elementAt(index).iconPath,
                    colorFilter:
                        const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 80,
                    child: Text(
                      maxLines: 3,
overflow: TextOverflow.ellipsis,
                      list.elementAt(index).value,
                      style: GoogleFonts.roboto(
                        textStyle: context.theme.b2,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    list.elementAt(index).description,
                    style: GoogleFonts.roboto(
                        textStyle: context.theme.b2,
                        color: AppColors.textAdditionalColor),
                  ),
                ],
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemCount: list.length),
      ),
    );
  }
}

// class _AdditionalInfoDescriptionColumnWidget extends StatelessWidget {
//   const _AdditionalInfoDescriptionColumnWidget(
//       {Key? key, required this.parameters})
//       : super(key: key);
//   final WeatherParameters parameters;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Ветер северо-восточный',
//           style: GoogleFonts.roboto(
//             textStyle: context.theme.b2,
//             color: AppColors.textAdditionalColor,
//           ),
//         ),
//         const SizedBox(
//           height: 16,
//         ),
//         Text(
//           'Высокая влажность',
//           style: GoogleFonts.roboto(
//             textStyle: context.theme.b2,
//             color: AppColors.textAdditionalColor,
//           ),
//         ),
//       ],
//     );
//   }
// }

/*
      final geo = Geo();
      final service = await geo.checkServiceAvailability();
      print('!!! Service $service');
      final permission = await geo.checkLocationPermission();
      print('!!! Permission $permission');

      LocationDto? locationDto;
      try {
        final position = await geo.getCurrentPosition();
        print('!!! Position $position');
        locationDto = LocationDto.fromPosition(position: position);
      } on GeoException catch (exception) {
        exception.error.handleGeoError(context);
        print('Error: $exception');
      } on TimeoutException catch (exception) {
        GeoError.geoTimeoutError.handleGeoError(context);
        print('Error2: $exception');
      } catch (err) {
        GeoError.geoUnknownError.handleGeoError(context);
        print('Error3: $err');
      } finally {
        locationDto ??= LocationDto.initial();
      }
      print('!!! Location $locationDto');
      final location = await geo.getPositionAddress(location: locationDto,);
      print('NEW location: $location');

 */

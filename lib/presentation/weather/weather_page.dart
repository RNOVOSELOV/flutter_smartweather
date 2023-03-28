import 'package:cached_network_image/cached_network_image.dart';
import 'package:css_filter/css_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/data/data_converter.dart';
import 'package:weather/data/dto/forecast_dto.dart';
import 'package:weather/data/dto/location_dto.dart';
import 'package:weather/data/dto/weather_additional_dto.dart';
import 'package:weather/data/dto/weather_dto.dart';
import 'package:weather/di/service_locator.dart';
import 'package:weather/presentation/weather/bloc/weather_bloc.dart';
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
      body: RefreshIndicator(
        color: AppColors.lightPink,
        onRefresh: () async {
          context.read<WeatherBloc>().add(const WeatherResendQuery());
        },
        child: BlocListener<WeatherBloc, WeatherState>(
          listener: (context, state) {
            if (state is WeatherShowApiError) {
              showError(context, state.message, state.canResend);
            } else if (state is WeatherShowGeoError) {
              state.error.handleGeoError(context);
            }
          },
          child: Container(
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
        ),
      ),
    );
  }

  void showError(BuildContext context, String message, bool resend) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: context.theme.b2,
            ),
          ),
          if (resend)
            const SizedBox(
              width: 12,
            ),
          if (resend)
            ElevatedButton(
                onPressed: () =>
                    context.read<WeatherBloc>().add(const WeatherResendQuery()),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  padding: const EdgeInsets.all(4),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text(
                    AppStrings.fixButtonLabel,
                    style: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      height: 22 / 15,
                      color: AppColors.textWhiteColor,
                    ),
                  ),
                )),
        ],
      ),
      backgroundColor: AppColors.gunMetalColor,
      duration: const Duration(seconds: 5),
      elevation: 4,
      behavior: SnackBarBehavior.floating,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      margin: const EdgeInsets.symmetric(horizontal: 24),
    ));
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
    List<ForecastDto> forecasts = <ForecastDto>[];
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
          forecasts = state.data.forecasts;
        }

        return Stack(
          children: [
            CSSFilter.blur(
              child: CustomScrollView(
                slivers: [
                  _AppBarWidget(
                    location:
                        locationData != null ? locationData!.location : '',
                    imageId: weatherData != null ? weatherData!.id : 801,
                  ),
                  _MainWeatherInfoWidget(weather: weatherData),
                  _DayWeatherInfoWidget(forecasts: forecasts),
                  _AdditionalWeatherInfoWidget(data: additionalWeatherData),
                ],
              ),
              value: inProgress ? 1 : 0,
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
  const _AppBarWidget({
    Key? key,
    required this.location,
    required this.imageId,
  }) : super(key: key);
  final int imageId;
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
                      DataConverter.getBigWeatherIcon(imageId),
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
  const _DayWeatherInfoWidget({
    Key? key,
    required this.forecasts,
  }) : super(key: key);

  final List<ForecastDto> forecasts;

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
                    '${DateTime.now().day} ${DataConverter.getMonth()}',
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
                  itemCount: forecasts.length,
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
                      child: _CartInDayListWidget(
                          forecast: forecasts.elementAt(index)),
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
  const _CartInDayListWidget({Key? key, required this.forecast})
      : super(key: key);

  final ForecastDto forecast;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 16),
        Text(
          DataConverter.getTimeFromUtcSeconds(forecast.dt),
          style: context.theme.b2,
        ),
        const SizedBox(height: 8),
        CachedNetworkImage(
          height: 48,
          width: 48,
          placeholder: (context, url) => const Padding(
            padding: EdgeInsets.all(12),
            child: CircularProgressIndicator(
              color: AppColors.lightPink,
            ),
          ),
          imageUrl: forecast.icon,
          errorWidget: (context, url, error) => Padding(
            padding: const EdgeInsets.all(8),
            child: Image.asset(
              AppImages.iconCloudSun,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '${forecast.temperature}º',
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
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: AppColors.backgroundCardColor,
        ),
        child: ListView.separated(
            padding: const EdgeInsets.all(16.0),
            physics: const NeverScrollableScrollPhysics(),
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

/*
      final geo = Geo();
      final service = await geo.checkServiceAvailability();
      print('!!! Service $service');
      final permission = await geo.checkLocationPermission();
      print('!!! Permission $permission');



 */

import 'package:css_filter/css_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/resources/app_colors.dart';
import 'package:weather/resources/app_images.dart';
import 'package:weather/resources/app_strings.dart';
import 'package:weather/theme/theme_extensions.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
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
        child: const Stack(
          children: [
            CustomScrollView(
              slivers: [
                _AppBarWidget(),
                _MainWeatherInfoWidget(),
                _DayWeatherInfoWidget(),
                _AdditionalWeatherInfoWidget(),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 270,
                  ),
                )
              ],
            ),
            _LocationBar(),
          ],
        ),
      ),
    );
  }
}

class _LocationBar extends StatelessWidget {
  const _LocationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 62,
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
            Text('Архангельск, Россия',
                style: GoogleFonts.roboto(
                  textStyle: context.theme.b2,
                  fontWeight: FontWeight.w500,
                )),
          ],
        ),
      ),
    );
  }
}

class _AppBarWidget extends StatelessWidget {
  const _AppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      primary: true,
      stretch: true,
      pinned: true,
      floating: true,
      expandedHeight: 272,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        stretchModes: const [
          StretchMode.blurBackground,
          StretchMode.zoomBackground
        ],
        background: Column(
          children: [
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
    );
  }
}

class _MainWeatherInfoWidget extends StatelessWidget {
  const _MainWeatherInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '27º',
            style: GoogleFonts.ubuntu(
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w500,
                fontSize: 64,
                height: 72 / 64,
                color: AppColors.textWhiteColor),
          ),
          Text(
            'Ясно',
            style: context.theme.b1,
          ),
          const SizedBox(height: 8),
          Text(
            '${AppStrings.maxTemperature} 31º ${AppStrings.minTemperature} 25º',
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
                    AppStrings.currentDay,
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
  const _AdditionalWeatherInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.only(left: 24, right: 24, bottom: 38),
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: AppColors.backgroundCardColor,
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _AdditionalInfoValuesColumnWidget(),
            _AdditionalInfoDescriptionColumnWidget(),
          ],
        ),
      ),
    );
  }
}

class _AdditionalInfoValuesColumnWidget extends StatelessWidget {
  const _AdditionalInfoValuesColumnWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              AppImages.iconWind,
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 8),
            Text(
              '2 ${AppStrings.windSpeed}',
              style: GoogleFonts.roboto(
                textStyle: context.theme.b2,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              AppImages.iconDrop,
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 8),
            Text(
              '100 %',
              style: GoogleFonts.roboto(
                textStyle: context.theme.b2,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _AdditionalInfoDescriptionColumnWidget extends StatelessWidget {
  const _AdditionalInfoDescriptionColumnWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ветер северо-восточный',
          style: GoogleFonts.roboto(
            textStyle: context.theme.b2,
            color: AppColors.textAdditionalColor,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          'Высокая влажность',
          style: GoogleFonts.roboto(
            textStyle: context.theme.b2,
            color: AppColors.textAdditionalColor,
          ),
        ),
      ],
    );
  }
}

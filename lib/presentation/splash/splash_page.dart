import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/navigation/route_name.dart';
import 'package:weather/resources/app_colors.dart';
import 'package:weather/resources/app_images.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late double x;
  late double y;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      y = MediaQuery.of(context).size.height / 8;
      setState(() {});
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    y = -100;
    x = MediaQuery.of(context).size.width * 0.7 - 50;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
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
      child: Stack(
        children: [
          AnimatedPositioned(
            top: y,
            left: x,
            duration: const Duration(milliseconds: 1500),
            curve: Curves.easeInOutQuad,
            onEnd: () {
              Navigator.of(context)
                  .pushReplacementNamed(RouteName.weather.route);
            },
            child: Lottie.asset(
              AppImages.bigSunny,
              height: 100,
              width: 100,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Lottie.asset(
              AppImages.logoM,
              height: 200,
              fit: BoxFit.fitHeight,
              animate: true,
            ),
          )
        ],
      ),
    ));
  }
}

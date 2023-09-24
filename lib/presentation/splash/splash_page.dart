import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/navigation/route_name.dart';
import 'package:weather/presentation/splash/splash_bloc.dart';
import 'package:weather/resources/app_colors.dart';
import 'package:weather/resources/app_images.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late double _x;
  late double _y;

  late SplashBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = SplashBloc ();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _y = MediaQuery.of(context).size.height / 8;
      setState(() {});
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _y = -100;
    _x = MediaQuery.of(context).size.width * 0.7 - 100;
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
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
            top: _y,
            left: _x,
            duration: const Duration(milliseconds: 2000),
            curve: Curves.easeInOutQuad,
            onEnd: () {
              // Navigator.of(context)
              //     .pushReplacementNamed(RouteName.weather.route);
              _bloc.splashAnimationCompleted();
            },
            child: Lottie.asset(
              AppImages.bigSunny,
              height: 200,
              width: 200,
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

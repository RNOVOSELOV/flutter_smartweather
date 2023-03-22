import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather/navigation/route_name.dart';
import 'package:weather/resources/app_colors.dart';
import 'package:weather/resources/app_images.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  double opacity = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => setState(() => opacity = 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.splashTopGradientColor,
            AppColors.splashBottomGradientColor
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          const Spacer(flex: 1),
          AnimatedOpacity(
            opacity: opacity,
            duration: const Duration(milliseconds: 1500),
            curve: Curves.easeOutQuad,
//            onEnd: () => Navigator.of(context)
//                .pushReplacementNamed(RouteName.login.route),
            child: SvgPicture.asset(
              AppImages.logo,
              height: 72,
              alignment: Alignment.center,
            ),
          ),
          const Spacer(flex: 614 ~/ 140),
        ],
      ),
    ));
  }
}

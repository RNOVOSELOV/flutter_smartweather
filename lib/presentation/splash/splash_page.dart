import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:weather/di/service_locator.dart';
import 'package:weather/navigation/router.dart';
import 'package:weather/presentation/splash/splash_bloc.dart';
import 'package:weather/resources/app_colors.dart';
import 'package:weather/resources/app_images.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late SplashBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = sl.get<SplashBloc>();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: _bloc,
      child: Scaffold(
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
          child: StreamBuilder<SplashPageState>(
              stream: _bloc.observeSplashPageState(),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data == null) {
                  return const SizedBox.shrink();
                }
                final splashPageState = snapshot.data!;
                switch (splashPageState) {
                  case SplashPageState.completedState:
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      context.router.replace(const WeatherRoute());
                    });
                    return const SizedBox.shrink();
                  case SplashPageState.internalLogicState:
                    return const _AnimationWidget();
                  case SplashPageState.initialState:
                    return const SizedBox.shrink();
                }
              }),
        ),
      ),
    );
  }
}

class _AnimationWidget extends StatefulWidget {
  const _AnimationWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<_AnimationWidget> createState() => _AnimationWidgetState();
}

class _AnimationWidgetState extends State<_AnimationWidget> {
  static const double sunSize = 200;

  double _y = (-1) * sunSize;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _y = MediaQuery.of(context).size.height / 20;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final SplashBloc bloc = Provider.of<SplashBloc>(context, listen: false);
    return Stack(
      children: [
        AnimatedPositioned(
          top: _y,
          left: MediaQuery.of(context).size.width * 0.7 - (sunSize / 2),
          duration: const Duration(milliseconds: 2000),
          curve: Curves.easeOutQuint,
          onEnd: () {
            bloc.splashAnimationCompleted();
          },
          child: Lottie.asset(
            AppImages.bigSunny,
            height: sunSize,
            width: sunSize,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Lottie.asset(
            AppImages.logoM,
            height: MediaQuery.of(context).size.height * 0.7,
            fit: BoxFit.fitHeight,
            animate: true,
          ),
        ),
      ],
    );
  }
}

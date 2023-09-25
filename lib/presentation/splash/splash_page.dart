import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/navigation/route_name.dart';
import 'package:weather/presentation/splash/splash_bloc.dart';
import 'package:weather/resources/app_colors.dart';
import 'package:weather/resources/app_images.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

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
        child: const _AnimationWidget(),
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

  late double _x;
  late double _y;

  late final SplashBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = SplashBloc();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _y = MediaQuery.of(context).size.height / 20;
      setState(() {});
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _y = (-1) * sunSize;
    _x = MediaQuery.of(context).size.width * 0.7 - (sunSize / 2);
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SplashPageState>(
      stream: _bloc.observeSplashPageState(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data == null) {
          return const SizedBox.shrink();
        }
        final splashPageState = snapshot.data!;
        switch (splashPageState) {
          case SplashPageState.completedState:
            WidgetsBinding.instance.addPostFrameCallback((_) =>
                Navigator.of(context)
                    .pushReplacementNamed(RouteName.weather.route));
            break;
          case SplashPageState.internalLogicState:
            // TODO: Handle this case.
            break;
        }
        return Stack(
          children: [
            AnimatedPositioned(
              top: _y,
              left: _x,
              duration: const Duration(milliseconds: 2000),
              curve: Curves.easeOutQuint,
              onEnd: () {
                _bloc.splashAnimationCompleted();
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
      },
    );
  }
}

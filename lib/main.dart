import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:weather/di/service_locator.dart';
import 'package:weather/navigation/router.dart';
import 'package:weather/theme/light_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');

  initServiceLocator();
  FlutterError.onError = (details) => sl.get<Talker>().handle(
        details.exception,
        details.stack,
      );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter();
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(),
      title: 'Smart Weather',
      routerConfig: appRouter.config(
        navigatorObservers: () => [TalkerRouteObserver(sl.get<Talker>())],
      ),
    );
  }

  ThemeData _buildTheme() {
    var baseTheme = lightTheme;
    return baseTheme.copyWith(
      textTheme: GoogleFonts.robotoTextTheme(baseTheme.textTheme),
    );
  }
}

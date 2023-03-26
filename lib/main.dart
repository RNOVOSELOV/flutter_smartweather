import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/di/service_locator.dart';
import 'package:weather/navigation/route_generator.dart';
import 'package:weather/theme/light_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
//  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
//    statusBarColor: Colors.transparent,
//  ));
  await dotenv.load(fileName: '.env');
  initServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(),
      title: 'Smart Weather',
      onGenerateRoute: generateRoute(),
    );
  }

  ThemeData _buildTheme() {
    var baseTheme = lightTheme;
    return baseTheme.copyWith(
      textTheme: GoogleFonts.robotoTextTheme(baseTheme.textTheme),
    );
  }
}

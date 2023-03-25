import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/navigation/route_generator.dart';
import 'package:weather/theme/light_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
//  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
//    statusBarColor: Colors.transparent,
//  ));
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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

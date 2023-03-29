import 'package:flutter/material.dart';

extension ThemeBuildContext on BuildContext {
  ThemeData get theme => Theme.of(this);
}

extension ThemeStylesExtension on ThemeData {
  TextStyle get h1 => textTheme.displayLarge!;

  TextStyle get h2 => textTheme.displayMedium!;

  TextStyle get b1 => textTheme.bodyLarge!;

  TextStyle get b2 => textTheme.bodyMedium!;

  TextStyle get b3 => textTheme.bodySmall!;

  TextStyle get button => textTheme.labelLarge!;
}

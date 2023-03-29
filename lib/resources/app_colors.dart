import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const whiteColor = Colors.white;
  static const gunMetalColor = Color(0xFF2B2D33);
  static const coolGreyColor = Color(0xFF8799A5);
  static const brightGrayColor = Color(0xFFE4E6EC);
  static const mediumPurpleColor = Color(0xFF9C53F6);
  static const heliotropeColor = Color(0xFFBD87FF);
  static const grapeColor = Color(0xFF330072);
  static const redColor = Color(0xFFFF585D);
  static const lightPink = Color(0xFFE71251);

  static const Color backgroundTopGradientColor = grapeColor;
  static const Color backgroundEndGradientColor = Color(0xFF4B00A7);
  static const Color backgroundBlurColor = heliotropeColor;
  static const Color backgroundCardColor = Color(0xFF380676);
  static const Color backgroundActiveCartColor = Color(0xFF46009C);

  static const Color dividerColor = mediumPurpleColor;
  static const Color activeCartBorderColor = mediumPurpleColor;

  static const Color textThemeColor = gunMetalColor;
  static const Color textGreyColor = coolGreyColor;
  static const Color textStrokeColor = brightGrayColor;
  static const Color textWhiteColor = whiteColor;
  static const Color textAdditionalColor = backgroundBlurColor;
  static const Color textDateColor = backgroundBlurColor;

  static const Color cursorColor = redColor;
  static final Color selectionColor = redColor.withOpacity(0.4);
  static const Color hintErrorColor = lightPink;
}

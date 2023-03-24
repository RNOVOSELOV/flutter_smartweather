import 'package:flutter/material.dart';
import 'package:weather/resources/app_colors.dart';

final _base = ThemeData.light();

final lightTheme = _base.copyWith(
  textTheme: _base.textTheme.copyWith(
    displayLarge: const TextStyle(
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 32,
      height: 36 / 32,
      color: AppColors.textWhiteColor,
    ),
    displayMedium: const TextStyle(
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 22,
      height: 28 / 22,
      color: AppColors.textWhiteColor,
    ),
    bodyLarge: const TextStyle(
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      fontSize: 17,
      height: 24 / 17,
      color: AppColors.textWhiteColor,
    ),
    bodyMedium: const TextStyle(
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      fontSize: 15,
      height: 22 / 15,
      color: AppColors.textWhiteColor,
    ),
    bodySmall: const TextStyle(
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      fontSize: 13,
      height: 18 / 13,
      color: AppColors.textWhiteColor,
    ),
    labelLarge: const TextStyle(
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 17,
      height: 24 / 17,
      color: AppColors.textWhiteColor,
    ),
  ),
);

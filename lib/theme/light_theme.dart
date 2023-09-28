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
      color: AppColors.textThemeColor,
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
  textSelectionTheme: _base.textSelectionTheme.copyWith(
    cursorColor: AppColors.cursorColor,
    selectionColor: AppColors.selectionColor,
    selectionHandleColor: AppColors.cursorColor,
  ),
  inputDecorationTheme: _base.inputDecorationTheme.copyWith(
    filled: true,
    fillColor: AppColors.coolGreyColor.withOpacity(0.8),
    isDense: true,
    errorStyle: const TextStyle(
      color: AppColors.hintErrorColor,
    ),
    contentPadding: const EdgeInsets.symmetric(vertical: 8),
    border: const OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.coolGreyColor, width: 1),
      borderRadius: BorderRadius.all(Radius.circular(16)),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.coolGreyColor, width: 2),
      borderRadius: BorderRadius.all(Radius.circular(16)),
    ),
    errorBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.lightPink, width: 1),
      borderRadius: BorderRadius.all(Radius.circular(16)),
    ),
    focusedErrorBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.lightPink, width: 2),
      borderRadius: BorderRadius.all(Radius.circular(0.5)),
    ),
    hintStyle: _base.primaryTextTheme.bodyLarge!.copyWith(
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      fontSize: 17,
      height: 24 / 17,
      color: AppColors.textGreyColor,
    ),
    labelStyle: _base.primaryTextTheme.bodyLarge!.copyWith(
      color: AppColors.textGreyColor,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      fontSize: 17,
      height: 24 / 17,
    ),
    floatingLabelStyle: const TextStyle(
      color: AppColors.textGreyColor,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      fontSize: 15,
      height: 22 / 15,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      padding:
          MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 12)),
      elevation: MaterialStateProperty.all(6),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      textStyle: MaterialStateProperty.all(
        const TextStyle(
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w500,
          fontSize: 17,
          height: 24 / 17,
          color: AppColors.textWhiteColor,
        ),
      ),
      backgroundColor: MaterialStateProperty.all(AppColors.redColor),
    ),
  ),
);

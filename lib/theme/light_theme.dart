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
    errorStyle: const TextStyle(
      color: AppColors.hintErrorColor,
    ),
    contentPadding: const EdgeInsets.only(top: 5, bottom: 11),
    border: const UnderlineInputBorder(
      borderSide: BorderSide(color: AppColors.brightGrayColor, width: 1),
      borderRadius: BorderRadius.all(Radius.circular(0.5)),
    ),
    focusedBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: AppColors.grapeColor, width: 2),
      borderRadius: BorderRadius.all(Radius.circular(0.5)),
    ),
    errorBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: AppColors.lightPink, width: 1),
      borderRadius: BorderRadius.all(Radius.circular(0.5)),
    ),
    focusedErrorBorder: const UnderlineInputBorder(
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
      elevation: MaterialStateProperty.all(4),
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

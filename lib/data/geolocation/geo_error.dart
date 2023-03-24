import 'package:flutter/material.dart';
import 'package:weather/resources/app_colors.dart';
import 'package:weather/resources/app_strings.dart';
import 'package:weather/theme/theme_extensions.dart';

class GeoException implements Exception {
  final GeoError error;

  GeoException({required this.error});
}

enum GeoError {
  geoServiceDisabled(description: AppStrings.geoServiceDisabled),
  geoPermissionDenied(description: AppStrings.geoPermissionDisabled),
  geoPermissionDeniedForever(
      description: AppStrings.geoPermissionDisabledForever),
  geoTimeoutError(description: AppStrings.geoTimeoutError),
  geoUnknownError(description: AppStrings.geoUnknownError);

  final String description;

  const GeoError({required this.description});

  void handleGeoError(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          description,
          textAlign: TextAlign.center,
          style: context.theme.b1,
        ),
        backgroundColor: AppColors.lightPink,
        duration: const Duration(seconds: 5),
        elevation: 4,
        behavior: SnackBarBehavior.floating,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12))),
        margin: const EdgeInsets.symmetric(horizontal: 24),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
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
    VoidCallback? fixProblemCallback = GeoError.getFixCallback(this);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                description,
                textAlign: fixProblemCallback == null
                    ? TextAlign.center
                    : TextAlign.center,
                style: context.theme.b2,
              ),
            ),
            if (fixProblemCallback != null)
              const SizedBox(
                width: 12,
              ),
            if (fixProblemCallback != null)
              ElevatedButton(
                  onPressed: fixProblemCallback,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    padding: const EdgeInsets.all(4),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Text(
                      AppStrings.fixButtonLabel,
                      style: TextStyle(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        height: 22 / 15,
                        color: AppColors.textWhiteColor,
                      ),
                    ),
                  )),
          ],
        ),
        backgroundColor: AppColors.gunMetalColor,
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

  static VoidCallback? getFixCallback(final GeoError error) {
    if (error == GeoError.geoServiceDisabled) {
      return () async {
        await Geolocator.openLocationSettings();
      };
    } else if (error == GeoError.geoPermissionDenied ||
        error == GeoError.geoPermissionDeniedForever) {
      return () async {
        await Geolocator.openAppSettings();
      };
    }
    return null;
  }
}

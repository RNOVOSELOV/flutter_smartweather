import 'package:weather/resources/app_strings.dart';

class Helper {
  Helper._();

  static String getHumidity(int value) {
    if (value < 40) {
      return AppStrings.parameterBadHumidity;
    } else if (value > 60) {
      return AppStrings.parameterHighHumidity;
    }
    return AppStrings.parameterHumidity;
  }

  static String getCloudy(int value) {
    if (value <= 10) {
      return AppStrings.parameterNoClouds;
    } else if (value <= 30) {
      return AppStrings.parameterLowClouds;
    } else if (value <= 70) {
      return AppStrings.parameterMiddleClouds;
    }
    return AppStrings.parameterHighClouds;
  }

  static String getSunTime (int value) {
    return DateTime.fromMillisecondsSinceEpoch(value * 1000, isUtc: true).toString();
  }

  static String getWindDirection(int angle) {
    final result = angle / 22.5;
    switch (result.floor()) {
      case 1:
      case 2:
        return AppStrings.windNE;
      case 3:
      case 4:
        return AppStrings.windE;
      case 5:
      case 6:
        return AppStrings.windSE;
      case 7:
      case 8:
        return AppStrings.windS;
      case 9:
      case 10:
        return AppStrings.windSW;
      case 11:
      case 12:
        return AppStrings.windW;
      case 13:
      case 14:
        return AppStrings.windNW;
      default:
        return AppStrings.windN;
    }
  }
}

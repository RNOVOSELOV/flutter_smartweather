import 'package:weather/resources/app_images.dart';
import 'package:weather/resources/app_strings.dart';

class DataConverter {
  DataConverter._();

  static String getBigWeatherIcon(int id) {
    if (id < 299) {
      return AppImages.bigIconThunderstorm;
    } else if (id <= 311) {
      return AppImages.bigIconLowRain;
    }else if (id < 399) {
      return AppImages.bigIconRain;
    } else if (id <= 504) {
      return AppImages.bigIconSunWithRain;
    } else if (id <= 599) {
      return AppImages.bigIconRainfall;
    } else if (id <= 699) {
      return AppImages.bigIconSnow;
    } else if (id == 800) {
      return AppImages.bigIconSun;
    } else if (id == 801) {
      return AppImages.bigIconSunWithCloud;
    } else if (id == 802) {
      return AppImages.bigIconCloud;
    } else if (id == 803) {
      return AppImages.bigIconClouds;
    } else if (id == 804) {
      return AppImages.bigIconClouds;
    } else {
      return AppImages.bigIconClouds;
    }
  }

  static String getHumidity(int value) {
    if (value < 40) {
      return AppStrings.parameterBadHumidity;
    } else if (value > 60) {
      return AppStrings.parameterHighHumidity;
    }
    return AppStrings.parameterHumidity;
  }

  static String getPressure(int value) {
    if (value < 1013.25) {
      return AppStrings.parameterPressureLow;
    }
    return AppStrings.parameterPressureHigh;
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

  static String getTimeFromUtcSeconds(int value) {
    final dateTime =
        DateTime.fromMillisecondsSinceEpoch(value * 1000, isUtc: true);
    return '${_getFormattedTime(dateTime.hour)}:${_getFormattedTime(dateTime.minute)}';
  }

  static String _getFormattedTime(int value) {
    if (value < 10) {
      return '0$value';
    }
    return '$value';
  }

  static String getVisibility(int value) {
    return value < 500
        ? AppStrings.parameterBadVisibility
        : AppStrings.parameterVisibility;
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

  static String getMonth() {
    switch (DateTime.now().month) {
      case 1:
        return 'января';
      case 2:
        return 'февраля';
      case 3:
        return 'марта';
      case 4:
        return 'апреля';
      case 5:
        return 'мая';
      case 6:
        return 'июня';
      case 7:
        return 'июля';
      case 8:
        return 'августа';
      case 9:
        return 'сентября';
      case 10:
        return 'октября';
      case 11:
        return 'ноября';
      default:
        return 'декабря';
    }
  }
}

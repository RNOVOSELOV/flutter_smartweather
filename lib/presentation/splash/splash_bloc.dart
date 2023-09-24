import 'package:weather/data/http/repositories/api_repository.dart';
import 'package:weather/data/storage/repositories/location_repository.dart';
import 'package:weather/di/service_locator.dart';

class SplashBloc {
  late final LocalWeatherStorageRepository storageWeatherDataRepository;
  late final ApiRepository apiDataRepository;

  SplashBloc() {
    storageWeatherDataRepository = sl.get<LocalWeatherStorageRepository>();
    apiDataRepository = sl.get<ApiRepository>();
    updateStorageData();
  }

  Future<void> updateStorageData() async {
    final savedData = await storageWeatherDataRepository.getItem();
    if (savedData != null) {
      final result = await apiDataRepository.getWeatherForecast(
          location: savedData.location);
      if (result.isRight) {
        await storageWeatherDataRepository.setItem(result.right);
      }
    }
  }

  void dispose() {}

  void splashAnimationCompleted () {
    print('!!! Animation completed');
  }

}

import 'package:rxdart/rxdart.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:weather/data/http/repositories/api_repository.dart';
import 'package:weather/data/storage/repositories/location_repository.dart';

class SplashBloc {
  final LocalWeatherStorageRepository storageWeatherDataRepository;
  final ApiRepository apiDataRepository;
  final Talker talker;

  final BehaviorSubject<SplashPageState> stateSubject =
      BehaviorSubject.seeded(SplashPageState.initialState);

  bool animationIsCompleted = false;
  bool apiDataRequestsCompleted = false;

  SplashBloc({
    required this.storageWeatherDataRepository,
    required this.apiDataRepository,
    required this.talker,
  }) {
    stateSubject.add(SplashPageState.internalLogicState);
    updateStorageData();
  }

  Stream<SplashPageState> observeSplashPageState() => stateSubject.distinct();

  Future<void> updateStorageData() async {
    final savedData = await storageWeatherDataRepository.getItem();
    if (savedData != null) {
      talker.info(
          'Splash screen - read saved data. Location: ${savedData.location}');
      final result = await apiDataRepository.getWeatherForecast(
          location: savedData.location);
      if (result.isRight) {
        await storageWeatherDataRepository.setItem(result.right);
      }
    } else {
      talker.info('Splash screen: saved data is null');
    }
    apiDataRequestsCompleted = true;
    openWeatherPage();
  }

  void dispose() {
    stateSubject.close();
  }

  void splashAnimationCompleted() {
    animationIsCompleted = true;
    openWeatherPage();
  }

  void openWeatherPage() {
    if (apiDataRequestsCompleted && animationIsCompleted) {
      stateSubject.add(SplashPageState.completedState);
    }
  }
}

enum SplashPageState {
  initialState,
  internalLogicState,
  completedState,
}

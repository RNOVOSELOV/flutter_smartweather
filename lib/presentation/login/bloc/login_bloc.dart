import 'dart:async';

import 'package:email_validator/email_validator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/data/geolocation/geo_repository.dart';
import 'package:weather/data/http/repositories/api_repository.dart';
import 'package:weather/data/storage/repositories/location_repository.dart';
import 'package:weather/presentation/login/models/login_errors.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  String password = '';

  final GeoRepository geoRepository;
  final ApiRepository apiDataRepository;
  final LocationRepository locationDataRepository;

  LoginBloc({
    required this.geoRepository,
    required this.apiDataRepository,
    required this.locationDataRepository,
  }) : super(const LoginState.initial()) {
    on<LoginEmailChanged>(_loginEmailChanged);
    on<LoginEmailEntered>(_loginEmailEntered);
    on<LoginPasswordChanged>(_loginPasswordChanged);
    on<LoginButtonPressed>(_loginButtonClicked);
    on<LoginErrorShowed>(_loginErrorShowed);
    on<LoginPageLoaded>(_loginPageLoaded);
  }

  FutureOr<void> _loginEmailChanged(
      final LoginEmailChanged event, final Emitter<LoginState> emit) {
    final email = event.email;
    emit(state.copyWith(
      email: email,
      emailIsValid: true,
      authenticated: false,
    ));
  }

  FutureOr<void> _loginPasswordChanged(
      final LoginPasswordChanged event, final Emitter<LoginState> emit) {
    password = event.password;
  }

  bool _emailValid(final String email) {
    return EmailValidator.validate(email);
  }

  FutureOr<void> _loginButtonClicked(
      final LoginButtonPressed event, final Emitter<LoginState> emit) {
    if (!_emailValid(state.email)) {
      emit(state.copyWith(
        emailIsValid: false,
        authenticated: false,
      ));
    } else {
      // TODO REALIZE HERE OAuth protocol
      emit(state.copyWith(authenticated: true));
    }
  }

  FutureOr<void> _loginErrorShowed(
      final LoginErrorShowed event, final Emitter<LoginState> emit) {
    state.copyWith(
      loginError: LoginError.noError,
    );
  }

  FutureOr<void> _loginEmailEntered(
      final LoginEmailEntered event, final Emitter<LoginState> emit) {
    if (!_emailValid(state.email)) {
      emit(state.copyWith(
        emailIsValid: false,
        authenticated: false,
      ));
    }
  }

  FutureOr<void> _loginPageLoaded(
      final LoginPageLoaded event, final Emitter<LoginState> emit) async {
    await geoRepository.initGeo();
    final lastPosition = await geoRepository.getLastKnownPosition();
    print('!!! LKNOWNP $lastPosition');

    if (lastPosition != null) {
      final result =
          await apiDataRepository.getWeatherForecast(location: lastPosition);
      if (result.isRight) {
        await locationDataRepository.setItem(result.right);
      }
    }
  }
}

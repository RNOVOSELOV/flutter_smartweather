part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginEmailChanged extends LoginEvent {
  final String email;

  const LoginEmailChanged(this.email);

  @override
  List<Object?> get props => [email];
}

class LoginPasswordChanged extends LoginEvent {
  final String password;

  const LoginPasswordChanged(this.password);

  @override
  List<Object?> get props => [password];
}

class LoginButtonPressed extends LoginEvent {
  const LoginButtonPressed();

  @override
  List<Object?> get props => [];
}

class LoginErrorShowed extends LoginEvent {
  const LoginErrorShowed();

  @override
  List<Object?> get props => [];
}

class LoginEmailEntered extends LoginEvent {
  const LoginEmailEntered();

  @override
  List<Object?> get props => [];
}

class LoginPageLoaded extends LoginEvent {
  const LoginPageLoaded();

  @override
  List<Object?> get props => [];
}

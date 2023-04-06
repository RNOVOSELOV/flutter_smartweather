part of 'login_bloc.dart';

class LoginState extends Equatable {
  final String email;
  final bool emailIsValid;
  final bool authenticated;     //
  final LoginError loginError;

  const LoginState({
    required this.email,
    required this.emailIsValid,
    required this.authenticated,
    required this.loginError,
  });

  const LoginState.initial()
      : this(
          authenticated: false,
          email: '',
          emailIsValid: true,
          loginError: LoginError.noError,
        );

  LoginState copyWith({
    final String? email,
    final bool? emailIsValid,
    final bool? authenticated,
    final LoginError? loginError,
  }) {
    return LoginState(
      email: email ?? this.email,
      authenticated: authenticated ?? this.authenticated,
      emailIsValid: emailIsValid ?? this.emailIsValid,
      loginError: loginError ?? this.loginError,
    );
  }

  @override
  List<Object?> get props => [
        email,
        emailIsValid,
        authenticated,
        loginError,
      ];
}

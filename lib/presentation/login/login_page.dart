import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/di/service_locator.dart';
import 'package:weather/navigation/route_name.dart';
import 'package:weather/presentation/login/bloc/login_bloc.dart';
import 'package:weather/presentation/login/models/login_errors.dart';
import 'package:weather/resources/app_colors.dart';
import 'package:weather/resources/app_strings.dart';
import 'package:weather/theme/theme_extensions.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl.get<LoginBloc>()..add(const LoginPageLoaded()),
      child: const Scaffold(
        body: _LoginPageWidget(),
      ),
    );
  }
}

class _LoginPageWidget extends StatefulWidget {
  const _LoginPageWidget({Key? key}) : super(key: key);

  @override
  State<_LoginPageWidget> createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<_LoginPageWidget> {
  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;

  @override
  void initState() {
    super.initState();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state.authenticated) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  RouteName.weather.route, (route) => false);
            }
          },
        ),
        BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state.loginError != LoginError.noError) {
              String warningMessage = '';
              final lError = state.loginError;
              // if (lError == LoginError.incorrectEmail) {
              //   warningMessage = 'Введен некоректный email';
              // }
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Flexible(
                  child: Text(
                    warningMessage,
                    textAlign: TextAlign.center,
                    style: context.theme.b2,
                  ),
                ),
                backgroundColor: AppColors.gunMetalColor,
                duration: const Duration(seconds: 5),
                elevation: 4,
                behavior: SnackBarBehavior.floating,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12))),
                margin: const EdgeInsets.symmetric(horizontal: 24),
              ));
              context.read<LoginBloc>().add(const LoginErrorShowed());
            }
          },
        ),
      ],
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 68),
                Text(
                  AppStrings.enterString,
                  style: context.theme.h1,
                ),
                const SizedBox(height: 12),
                Text(
                  AppStrings.enterDescriptionString,
                  style: GoogleFonts.roboto(
                    textStyle: context.theme.b2,
                    color: AppColors.textGreyColor,
                  ),
                ),
                const SizedBox(height: 24),
                _EmailTextField(
                  emailFocusNode: _emailFocusNode,
                  passwordFocusNode: _passwordFocusNode,
                ),
                const SizedBox(height: 32),
                _PasswordTextField(passwordFocusNode: _passwordFocusNode),
                const SizedBox(height: 48),
                const _LoginButtonWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EmailTextField extends StatelessWidget {
  const _EmailTextField({
    Key? key,
    required FocusNode emailFocusNode,
    required FocusNode passwordFocusNode,
  })  : _emailFocusNode = emailFocusNode,
        _passwordFocusNode = passwordFocusNode,
        super(key: key);

  final FocusNode _emailFocusNode;
  final FocusNode _passwordFocusNode;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<LoginBloc, LoginState, bool>(
      selector: (state) => state.emailIsValid,
      builder: (context, emailValid) {
        return TextField(
          expands: false,
          textAlignVertical: TextAlignVertical.center,
          textCapitalization: TextCapitalization.none,
          focusNode: _emailFocusNode,
          onChanged: (text) =>
              context.read<LoginBloc>().add(LoginEmailChanged(text)),
          onSubmitted: (_) => _emailIsEntered(context),
          onTapOutside: (_) => _emailIsEntered(context),
          autocorrect: false,
//      autofocus: true,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.go,
          autofillHints: const [AutofillHints.email],
          decoration: InputDecoration(
            labelText: AppStrings.emailInputLabel,
            errorText: emailValid ? null : 'Некорректный email',
          ),
        );
      },
    );
  }

  void _emailIsEntered(BuildContext context) {
    context.read<LoginBloc>().add(const LoginEmailEntered());
    _passwordFocusNode.requestFocus();
  }
}

class _PasswordTextField extends StatefulWidget {
  const _PasswordTextField({
    Key? key,
    required FocusNode passwordFocusNode,
  })  : _passwordFocusNode = passwordFocusNode,
        super(key: key);

  final FocusNode _passwordFocusNode;

  @override
  State<_PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<_PasswordTextField> {
  bool passwordIsHidden = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      expands: false,
      textAlignVertical: TextAlignVertical.center,
      textCapitalization: TextCapitalization.none,
      focusNode: widget._passwordFocusNode,
      onChanged: (text) =>
          context.read<LoginBloc>().add(LoginPasswordChanged(text)),
      onSubmitted: (_) {
        FocusManager.instance.primaryFocus?.unfocus();
        context.read<LoginBloc>().add(const LoginButtonPressed());
      },
      autocorrect: false,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
      autofillHints: const [AutofillHints.password],
      obscureText: passwordIsHidden,
      decoration: InputDecoration(
          labelText: "Пароль",
          suffixIcon: GestureDetector(
            child: Icon(
              passwordIsHidden
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              color: const Color(0xFF231F20),
            ),
            onTap: () => setState(() => passwordIsHidden = !passwordIsHidden),
          )
//          errorText: passwordError == PasswordError.noError
//              ? null
//              : 'Введен неверный пароль'
          ),
    );
  }
}

class _LoginButtonWidget extends StatelessWidget {
  const _LoginButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        FocusManager.instance.primaryFocus?.unfocus();
        context.read<LoginBloc>().add(const LoginButtonPressed());
      },
      child: const SizedBox(
          width: double.infinity,
          child: Text(
            AppStrings.enterButtonString,
            textAlign: TextAlign.center,
          )),
    );
  }
}

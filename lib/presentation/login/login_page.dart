import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/data/geolocation/geo.dart';
import 'package:weather/data/geolocation/geo_error.dart';
import 'package:weather/data/geolocation/models/location_dto.dart';
import 'package:weather/navigation/route_name.dart';
import 'package:weather/resources/app_colors.dart';
import 'package:weather/resources/app_strings.dart';
import 'package:weather/theme/theme_extensions.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _LoginPageWidget(),
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
    return Padding(
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
    return TextField(
      expands: false,
      textAlignVertical: TextAlignVertical.center,
      textCapitalization: TextCapitalization.none,
      focusNode: _emailFocusNode,
//      onChanged: (text) =>
//          context.read<LoginBloc>().add(LoginEmailChanged(text)),
      onSubmitted: (_) => _passwordFocusNode.requestFocus(),
      autocorrect: false,
//      autofocus: true,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.go,
      autofillHints: const [AutofillHints.email],
      decoration: InputDecoration(
        labelText: AppStrings.emailInputLabel,
//        errorText: emailError == EmailError.noError
//            ? null
//            : 'Пользователь с таким email не обнаружен',
      ),
    );
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
//      onChanged: (text) =>
//          context.read<LoginBloc>().add(LoginPasswordChanged(text)),
      onSubmitted: (_) {
        FocusManager.instance.primaryFocus?.unfocus();
//        context.read<LoginBloc>().add(LoginLoginButtonPressed());
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
        Navigator.of(context).pushReplacementNamed(RouteName.weather.route);
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

import 'package:flutter/material.dart';

import 'package:memory_game/core/utils/constanst/app_constans.dart';
import 'package:memory_game/features/login/domain/use_cases/create_with_email_and_password_use_case.dart';
import 'package:memory_game/features/login/domain/use_cases/login_with_email_and_password_use_case.dart';

class LogInProvider with ChangeNotifier {
  final LoginWithEmailAndPasswordUseCase loginWithEmailAndPasswordUseCase;
  final CreateWithEmailAndPasswordUseCase createWithEmailAndPasswordUseCase;
  bool isHiden = true;
  bool _isEmailNotValid = false;
  bool _isPasswordNotValid = false;
  String _email = '';
  String _password = '';

  LogInProvider({
    required this.loginWithEmailAndPasswordUseCase,
    required this.createWithEmailAndPasswordUseCase,
  });

  bool get isEmailNotValid => _isEmailNotValid;
  bool get isPasswordNotValid => _isPasswordNotValid;

  void toggleVisibility() {
    isHiden = !isHiden;
    notifyListeners();
  }

  void setEmail(String email) {
    _email = email;
  }

  void setPassword(String password) {
    _password = password;
  }

  void validateEmail() {
    if (!AppConstans.emailRegExp.hasMatch(_email)) {
      _isEmailNotValid = true;
      return;
    }
    _isEmailNotValid = false;
  }

  void validatePassword() {
    if (_password.length < 6) {
      _isPasswordNotValid = true;
      return;
    }
    _isPasswordNotValid = false;
  }

  void validateUser() {
    validateEmail();
    validatePassword();

    if (_isEmailNotValid && _isPasswordNotValid) {
      notifyListeners();
      return;
    }

    notifyListeners();
  }
}

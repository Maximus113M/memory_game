import 'package:flutter/material.dart';
import 'package:memory_game/config/utils/constanst/app_constans.dart';

class LogInProvider with ChangeNotifier {
  bool isHiden = true;
  bool _isEmailNotValid = false;
  bool _isPasswordNotValid = false;
  String _email = '';
  String _password = '';

  LogInProvider();

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

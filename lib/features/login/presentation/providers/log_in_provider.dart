import 'package:flutter/material.dart';

import 'package:memory_game/core/utils/constanst/app_constans.dart';
import 'package:memory_game/core/utils/constanst/in_app_notification.dart';
import 'package:memory_game/features/login/data/models/email_and_password_data.dart';
import 'package:memory_game/features/login/domain/use_cases/create_with_email_and_password_use_case.dart';
import 'package:memory_game/features/login/domain/use_cases/login_with_email_and_password_use_case.dart';

import 'package:go_router/go_router.dart';

class LogInProvider with ChangeNotifier {
  final LoginWithEmailAndPasswordUseCase loginWithEmailAndPasswordUseCase;
  final CreateWithEmailAndPasswordUseCase createWithEmailAndPasswordUseCase;
  bool isHidenPassword = true;
  bool isHidenConfirmPassword = true;
  bool _isEmailNotValid = false;
  bool _isPasswordNotValid = false;
  bool _isConfirmPasswordNotValid = false;
  bool _isLoadingEmailVerification = false;
  String _email = '';
  String _password = '';
  String _confirmPassword = '';

  LogInProvider({
    required this.loginWithEmailAndPasswordUseCase,
    required this.createWithEmailAndPasswordUseCase,
  });

  bool get isEmailNotValid => _isEmailNotValid;
  bool get isPasswordNotValid => _isPasswordNotValid;
  bool get isConfirmPasswordNotValid => _isConfirmPasswordNotValid;

  void togglePasswordVisibility() {
    isHidenPassword = !isHidenPassword;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    isHidenConfirmPassword = !isHidenConfirmPassword;
    notifyListeners();
  }

  void setEmail(String email) {
    _email = email;
  }

  void setPassword(String password) {
    _password = password;
  }

  void setConfirmPassword(String confirmPassword) {
    _confirmPassword = confirmPassword;
  }

  void validateEmail() {
    if (!AppConstans.emailRegExp.hasMatch(_email)) {
      _isEmailNotValid = true;
      return;
    }
    _isEmailNotValid = false;
  }

  void validatePassword() {
    if (_password.length < 8) {
      _isPasswordNotValid = true;
      return;
    }
    _isPasswordNotValid = false;
  }

  void validateConfirmPassword() {
    if (_password.length < 8 || _password != _confirmPassword) {
      _isConfirmPasswordNotValid = true;
      return;
    }

    _isConfirmPasswordNotValid = false;
  }

  void resetValues() {
    _email = '';
    _password = '';
    _confirmPassword = '';
    _isEmailNotValid = false;
    _isPasswordNotValid = false;
    _isConfirmPasswordNotValid = false;
    isHidenPassword = true;
    isHidenConfirmPassword = true;
  }

  void goToLogin(BuildContext context) {
    if (_isLoadingEmailVerification) return;
    GoRouter.of(context).pushReplacement('/login');
    resetValues();
    notifyListeners();
  }

  void goToSignIn(BuildContext context) {
    GoRouter.of(context).pushReplacement('/sign-up');
    resetValues();
    notifyListeners();
  }

  void validateLogin(BuildContext context) {
    validateEmail();
    validatePassword();

    if (_isEmailNotValid || _isPasswordNotValid) {
      InAppNotification.invalidEmailAndPassword(
        context: context,
      );
      notifyListeners();
      return;
    }
    final loginData = EmailAndPasswordData(email: _email, password: _password);
    loginWithEmailAndPassword(context, loginData);
    notifyListeners();
  }

  void loginWithEmailAndPassword(
      BuildContext context, EmailAndPasswordData loginData) async {
    final result = await loginWithEmailAndPasswordUseCase(loginData);

    result.fold((l) {
      InAppNotification.serverFailure(
        context: context,
        message: l.message,
      );
    }, (credential) {
      if (credential == null) return;
      if (credential.user == null) return;
      if (credential.user!.emailVerified) {
        GoRouter.of(context).pushReplacement('/home');
        notifyListeners();
      } else {
        InAppNotification.showAppNotification(
            context: context,
            title: 'Check your email',
            message:
                'Verification was sent to your email address, please check your email',
            type: NotificationType.warning);
      }
    });
  }

  void validateSignUp(BuildContext context) {
    if (_isLoadingEmailVerification) return;
    validateEmail();
    validateConfirmPassword();
    if (_isEmailNotValid || _isConfirmPasswordNotValid) {
      InAppNotification.invalidEmailAndPassword(
        context: context,
      );
      notifyListeners();
      return;
    }

    final signUpData = EmailAndPasswordData(email: _email, password: _password);
    createWithEmailAndPassword(context, signUpData);
    notifyListeners();
  }

  void createWithEmailAndPassword(
      BuildContext context, EmailAndPasswordData signUpData) async {
    _isLoadingEmailVerification = true;
    final result = await createWithEmailAndPasswordUseCase(signUpData);

    result.fold(
      (l) {
        InAppNotification.serverFailure(
          context: context,
          message: l.message,
        );
      },
      (credential) async {
        if (credential == null) {
          InAppNotification.serverFailure(
            context: context,
            message: 'a registration error has occurred',
          );
          return;
        }

        if (credential.user != null) {
          await credential.user!.sendEmailVerification().then(
            (value) async {
              InAppNotification.successfulRegistration(
                context: context,
              );
              await Future.delayed(const Duration(seconds: 3)).then(
                (value) {
                  GoRouter.of(context).pushReplacement('/login');
                  _isLoadingEmailVerification = false;
                },
              );
            },
          );
        }
      },
    );
  }
}

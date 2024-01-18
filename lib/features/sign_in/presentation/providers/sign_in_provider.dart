import 'package:flutter/material.dart';
import 'package:memory_game/core/helpers/use_case.dart';

import 'package:memory_game/core/utils/constanst/app_constans.dart';
import 'package:memory_game/core/utils/constanst/in_app_notification.dart';
import 'package:memory_game/features/sign_in/data/models/sign_in_user_data.dart';
import 'package:memory_game/features/sign_in/domain/use_cases/login_with_email_and_password_use_case.dart';
import 'package:memory_game/features/sign_in/domain/use_cases/create_with_email_and_password_use_case.dart';

import 'package:go_router/go_router.dart';
import 'package:memory_game/features/sign_in/domain/use_cases/send_password_reset_email_use_case.dart';
import 'package:memory_game/features/sign_in/domain/use_cases/verify_current_session_use_case.dart';
import 'package:memory_game/features/sign_in/presentation/widgets/reset_password_dialog.dart';

class SignInProvider with ChangeNotifier {
  final LoginWithEmailAndPasswordUseCase? loginWithEmailAndPasswordUseCase;
  final CreateWithEmailAndPasswordUseCase? createWithEmailAndPasswordUseCase;
  final VerifyCurrentSessionUseCase? verifyCurrentSessionUseCase;
  final SendPasswordResetEmailUseCase? sendPasswordResetEmailUseCase;
  bool isHidenPassword = true;
  bool isHidenConfirmPassword = true;
  bool _isNameNotValid = false;
  bool _isEmailNotValid = false;
  bool _isPasswordNotValid = false;
  bool _isConfirmPasswordNotValid = false;
  bool _isLoadingEmailVerification = false;
  bool isValidateUserData = false;
  String _name = '';
  String _email = '';
  String _password = '';
  String _confirmPassword = '';

  SignInProvider({
    this.loginWithEmailAndPasswordUseCase,
    this.createWithEmailAndPasswordUseCase,
    this.verifyCurrentSessionUseCase,
    this.sendPasswordResetEmailUseCase,
  });

  bool get isNameNotValid => _isNameNotValid;
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

  void setName(String name) {
    _name = name;
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

  void validateName() {
    if (_name.isEmpty) {
      _isNameNotValid = true;
      return;
    }
    _isNameNotValid = false;
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
    _name = '';
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
    final loginData = SignInUserData(email: _email, password: _password);
    loginWithEmailAndPassword(context, loginData);
    notifyListeners();
  }

  void loginWithEmailAndPassword(
      BuildContext context, SignInUserData signInData) async {
    final result = await loginWithEmailAndPasswordUseCase!(signInData);

    result.fold((l) {
      InAppNotification.serverFailure(
        context: context,
        message: l.message,
      );
    }, (credential) async {
      if (credential == null) return;
      if (credential.user == null) return;
      if (credential.user!.emailVerified) {
        isValidateUserData = true;
        await verifyCurrentSessionUseCase!(NoParams()).then((value) {
          isValidateUserData = false;
          notifyListeners();
          GoRouter.of(context).pushReplacement('/home');
        });
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
    validateName();
    validateEmail();
    validateConfirmPassword();
    if (_isNameNotValid || _isEmailNotValid || _isConfirmPasswordNotValid) {
      InAppNotification.invalidEmailAndPassword(
        context: context,
      );
      notifyListeners();
      return;
    }

    final signUpData =
        SignInUserData(name: _name, email: _email, password: _password);
    createWithEmailAndPassword(context, signUpData);
    notifyListeners();
  }

  void createWithEmailAndPassword(
      BuildContext context, SignInUserData signUpData) async {
    _isLoadingEmailVerification = true;
    final result = await createWithEmailAndPasswordUseCase!(signUpData);

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

  void showResetPasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => ResetPasswordDialog(
          sendConfirmation: () => sendPasswordResetEmail(context, _email),
          setEmail: (value) => setEmail(value),
          hideText: 'Email'),
    );
  }

  sendPasswordResetEmail(BuildContext context, email) async {
    print(_email);
    final result = await sendPasswordResetEmailUseCase!(email);
    result.fold(
      (l) {
        InAppNotification.serverFailure(context: context, message: l.message);
      },
      (r) {
        if (r) {
          InAppNotification.showAppNotification(
            context: context,
            title: 'Please, check your email!',
            message: 'A reset message was sent to your email address',
            type: NotificationType.success,
          );
        }
      },
    );
  }
}

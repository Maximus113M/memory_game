import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashProvider with ChangeNotifier {
  SplashProvider();

  void goToLogIn(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 4000))
        .then((value) => GoRouter.of(context).go('/login'));
  }
}

import 'package:flutter/material.dart';

import 'package:memory_game/core/utils/utils.dart';
import 'package:memory_game/core/helpers/use_case.dart';
import 'package:memory_game/features/splash/domain/use_cases/is_user_sign_in_use_case.dart';

import 'package:go_router/go_router.dart';

class SplashProvider with ChangeNotifier {
  final IsUserSignInUseCase isUserSignInUseCase;

  SplashProvider({
    required this.isUserSignInUseCase,
  });

  void appInit(BuildContext context) async {
    final result = await isUserSignInUseCase(NoParams());

    result.fold(
      (l) {
        InAppNotification.serverFailure(
          context: context,
          message: l.message,
        );
      },
      (r) async {
        if (r) {
          await Future.delayed(const Duration(milliseconds: 4000))
              .then((value) => GoRouter.of(context).go('/home'));
          return;
        }
        await Future.delayed(const Duration(milliseconds: 4000))
            .then((value) => GoRouter.of(context).go('/login'));
      },
    );
  }
}

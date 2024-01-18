import 'package:flutter/material.dart';
import 'package:memory_game/core/utils/utils.dart';

import 'package:memory_game/features/sign_in/presentation/providers/sign_in_provider.dart';
import 'package:memory_game/features/sign_in/presentation/widgets/log_in_body.dart';

import 'package:provider/provider.dart';

class LogInPage extends StatelessWidget {
  static const name = '/login';

  const LogInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.contrast,
      body: LogInBody(signInProvider: Provider.of<SignInProvider>(context)),
    );
  }
}

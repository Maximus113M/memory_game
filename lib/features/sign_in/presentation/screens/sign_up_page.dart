import 'package:flutter/material.dart';

import 'package:memory_game/core/utils/utils.dart';
import 'package:memory_game/features/sign_in/presentation/widgets/sign_up_body.dart';
import 'package:memory_game/features/sign_in/presentation/providers/sign_in_provider.dart';

import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {
  static const name = '/sign-up';

  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.contrast,
      body: SignUpBody(logInProvider: Provider.of<SignInProvider>(context)),
    );
  }
}

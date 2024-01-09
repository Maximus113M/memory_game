import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:memory_game/config/shared/widgets/shared_widgets.dart';

import 'package:memory_game/config/utils/utils.dart';
import 'package:memory_game/features/login/presentation/providers/log_in_provider.dart';
import 'package:memory_game/features/login/presentation/widgets/custom_text_form.dart';

class LogInBody extends StatelessWidget {
  final LogInProvider logInProvider;
  const LogInBody({super.key, required this.logInProvider});

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (BuildContext context, setState) {
      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: ScreenSize.height * 0.15,
              ),
              Image.asset(AppAssets.brain2, height: 150),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Login',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Sign in to continue!',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              const CustomTextForm(
                  icon: Icons.mail_outlined,
                  text: 'Email address',
                  showPassword: false),
              const SizedBox(
                height: 25,
              ),
              CustomTextForm(
                  icon: Icons.lock_outline,
                  text: 'Password',
                  showPassword: true,
                  isHiden: logInProvider.isHiden,
                  toggleVisibility: () {
                    logInProvider.toggleVisibility(setState);
                    print(logInProvider.isHiden);
                  }),
              const SizedBox(
                height: 50,
              ),
              CustomFilledButton(
                text: 'Log In',
                onPress: () {
                  GoRouter.of(context).push('/home');
                },
              )
            ],
          ),
        ),
      );
    });
  }
}

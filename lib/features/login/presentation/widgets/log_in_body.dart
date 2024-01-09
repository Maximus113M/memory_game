import 'package:flutter/material.dart';

import 'package:memory_game/config/utils/utils.dart';
import 'package:memory_game/config/shared/widgets/shared_widgets.dart';
import 'package:memory_game/features/login/presentation/providers/log_in_provider.dart';
import 'package:memory_game/features/login/presentation/widgets/custom_text_form.dart';
import 'package:memory_game/features/login/presentation/widgets/log_in_with_icon_container.dart';

import 'package:go_router/go_router.dart';

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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: ScreenSize.height * 0.14,
              ),
              Image.asset(AppAssets.brain2, height: 150),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Login',
                style: FontStyles.heading3(AppColors.text),
              ),
              const SizedBox(
                height: 3,
              ),
              Text('Sign in to continue!',
                  style: FontStyles.subtitle2(AppColors.text)),
              const SizedBox(
                height: 30,
              ),
              CustomTextForm(
                icon: Icons.mail_outlined,
                text: 'Email address',
                showPassword: false,
                error: logInProvider.isEmailNotValid,
                onChange: (value) => logInProvider.setEmail(value),
              ),
              const SizedBox(
                height: 22,
              ),
              CustomTextForm(
                icon: Icons.lock_outline,
                text: 'Password',
                showPassword: true,
                isHiden: logInProvider.isHiden,
                error: logInProvider.isPasswordNotValid,
                toggleVisibility: () => logInProvider.toggleVisibility(),
                onChange: (value) => logInProvider.setPassword(value),
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                child: Text(
                  'Forgot Password?',
                  style: FontStyles.bodyBold1(AppColors.text),
                ),
                onTap: () {},
              ),
              const SizedBox(
                height: 30,
              ),
              CustomFilledButton(
                text: 'LOGIN',
                textStyle: FontStyles.body0(AppColors.contrast),
                horizontalPadding: ScreenSize.width * 0.32,
                verticalPadding: 15,
                onPress: () {
                  logInProvider.validateUser();
                  //GoRouter.of(context).push('/home');
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Or Login with ',
                style: FontStyles.body2(AppColors.text),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      print('Mamahuevo');
                    },
                    child: LogInWithIconContainer(
                        imagePath: AppAssets.google,
                        imageSize: 28,
                        padding: 10),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      print('Mamahuevo');
                    },
                    child: LogInWithIconContainer(
                        imagePath: AppAssets.meta, imageSize: 28, padding: 10),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account?',
                    style: FontStyles.body0(AppColors.unfocused),
                  ),
                  GestureDetector(
                    child: Text(
                      ' Sign Up',
                      style: FontStyles.bodyBold1(AppColors.text),
                    ),
                    onTap: () {
                      print('Mamahuevo');
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}

import 'package:flutter/material.dart';

import 'package:memory_game/core/utils/utils.dart';
import 'package:memory_game/core/shared/widgets/shared_widgets.dart';
import 'package:memory_game/features/sign_in/presentation/providers/sign_in_provider.dart';
import 'package:memory_game/features/sign_in/presentation/widgets/log_in_with_icon_container.dart';

class LogInBody extends StatelessWidget {
  final SignInProvider signInProvider;

  const LogInBody({
    super.key,
    required this.signInProvider,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: ScreenSize.height * 0.13,
            ),
            Image.asset(AppAssets.brain2, height: 150),
            const SizedBox(
              height: 15,
            ),
            Text(
              'Login',
              style: FontStyles.heading2(AppColors.text),
            ),
            const SizedBox(
              height: 3,
            ),
            Text('Sign in to continue!',
                style: FontStyles.subtitle2(AppColors.text)),
            SizedBox(
              height: ScreenSize.height * 0.018,
            ),
            CustomTextForm(
              icon: Icons.mail_outlined,
              text: 'Email address',
              showPasswordButton: false,
              error: signInProvider.isEmailNotValid,
              onChange: (value) => signInProvider.setEmail(value),
            ),
            SizedBox(
              height: ScreenSize.height * 0.018,
            ),
            CustomTextForm(
              icon: Icons.lock_outline,
              text: 'Password',
              showPasswordButton: true,
              isHiden: signInProvider.isHidenPassword,
              error: signInProvider.isPasswordNotValid,
              toggleVisibility: () => signInProvider.togglePasswordVisibility(),
              onChange: (value) => signInProvider.setPassword(value),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              child: Text(
                'Forgot Password?',
                style: FontStyles.bodyBold1(AppColors.text),
              ),
              onTap: () {
                signInProvider.showResetPasswordDialog(context);
              },
            ),
            SizedBox(
              height: ScreenSize.height * 0.07,
            ),
            CustomFilledButton(
              text: 'LOGIN',
              textStyle: FontStyles.body0(AppColors.contrast),
              horizontalPadding: ScreenSize.width * 0.32,
              verticalPadding: 20,
              onPress: () {
                signInProvider.validateLogin(context);
              },
            ),
            const SizedBox(
              height: 15,
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
                      imagePath: AppAssets.google, imageSize: 28, padding: 10),
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
            SizedBox(
              height: ScreenSize.height * 0.02,
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
                  onTap: () => signInProvider.goToSignIn(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

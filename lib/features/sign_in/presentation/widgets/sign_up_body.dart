import 'package:flutter/material.dart';

import 'package:memory_game/core/utils/utils.dart';
import 'package:memory_game/core/shared/widgets/shared_widgets.dart';
import 'package:memory_game/features/sign_in/presentation/widgets/custom_text_form.dart';
import 'package:memory_game/features/sign_in/presentation/providers/sign_in_provider.dart';

class SignUpBody extends StatelessWidget {
  final SignInProvider logInProvider;

  const SignUpBody({
    super.key,
    required this.logInProvider,
  });

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context, setState) {
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
                  'Sign up',
                  style: FontStyles.heading2(AppColors.text),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text('Sign up to get started!',
                    style: FontStyles.subtitle2(AppColors.text)),
                SizedBox(
                  height: ScreenSize.height * 0.018,
                ),
                CustomTextForm(
                  icon: Icons.person_outlined,
                  text: 'Name',
                  showPassword: false,
                  error: logInProvider.isNameNotValid,
                  onChange: (value) => logInProvider.setName(value),
                ),
                SizedBox(
                  height: ScreenSize.height * 0.018,
                ),
                CustomTextForm(
                  icon: Icons.mail_outlined,
                  text: 'Email address',
                  showPassword: false,
                  error: logInProvider.isEmailNotValid,
                  onChange: (value) => logInProvider.setEmail(value),
                ),
                SizedBox(
                  height: ScreenSize.height * 0.018,
                ),
                CustomTextForm(
                  icon: Icons.lock_outline,
                  text: 'Password',
                  showPassword: true,
                  isHiden: logInProvider.isHidenPassword,
                  error: logInProvider.isConfirmPasswordNotValid,
                  toggleVisibility: () =>
                      logInProvider.togglePasswordVisibility(),
                  onChange: (value) => logInProvider.setPassword(value),
                ),
                SizedBox(
                  height: ScreenSize.height * 0.018,
                ),
                CustomTextForm(
                  icon: Icons.lock_outline,
                  text: 'Confirm Password',
                  showPassword: true,
                  isHiden: logInProvider.isHidenConfirmPassword,
                  error: logInProvider.isConfirmPasswordNotValid,
                  toggleVisibility: () =>
                      logInProvider.toggleConfirmPasswordVisibility(),
                  onChange: (value) => logInProvider.setConfirmPassword(value),
                ),
                SizedBox(
                  height: ScreenSize.height * 0.04,
                ),
                CustomFilledButton(
                  text: 'SIGN UP',
                  textStyle: FontStyles.body0(AppColors.contrast),
                  horizontalPadding: ScreenSize.width * 0.30,
                  verticalPadding: 20,
                  onPress: () {
                    logInProvider.validateSignUp(context);
                  },
                ),
                SizedBox(
                  height: ScreenSize.height * 0.035,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: FontStyles.body0(AppColors.unfocused),
                    ),
                    GestureDetector(
                      child: Text(
                        ' Sign In',
                        style: FontStyles.bodyBold0(AppColors.text),
                      ),
                      onTap: () => logInProvider.goToLogin(context),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

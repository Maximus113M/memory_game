import 'package:flutter/material.dart';

import 'package:memory_game/core/utils/utils.dart';
import 'package:memory_game/core/helpers/use_case.dart';
import 'package:memory_game/core/services/auth_service.dart';
import 'package:memory_game/core/services/audio_service.dart';
import 'package:memory_game/core/shared/models/user_settings_model.dart';
import 'package:memory_game/core/shared/widgets/dialogs/custom_input_dialog.dart';
import 'package:memory_game/features/global_config/domain/use_cases/use_cases.dart';
import 'package:memory_game/features/game/presentation/providers/game_provider.dart';
import 'package:memory_game/core/shared/widgets/dialogs/custom_confirmation_dialog.dart';
import 'package:memory_game/features/global_config/data/models/game_mode_menu_options.dart';
import 'package:memory_game/core/shared/widgets/dialogs/custom_verify_credentials_dialog.dart';

import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

class GlobalConfigProvider with ChangeNotifier {
  final UpdateUserNameUseCase updateUserNameUseCase;
  final UpdateEmailUseCase updateEmailUseCase;
  final UpdatePasswordUseCase updatePasswordUseCase;
  final DeleteAccountUseCase deleteAccountUseCase;
  final ValidateCredentialsUseCase validateCredentialsUseCase;
  final UpdateUserSettingsUseCase updateUserSettingsUseCase;
  final List<GameModeMenuOptions> gameModeMenuOptions =
      GameModeMenuOptions.gameModeMenuList;
  final String failTitle = 'Failed Update';
  final String failMessage = 'Unable to update, please try again';
  final NotificationType failType = NotificationType.error;
  final String successTitle = 'Succesful Update';
  final String successMessage = 'Update successfully completed';
  final NotificationType successType = NotificationType.success;

  GameDifficulty currentGameMode = GameDifficulty.easy;
  int memorizingTime = 5;
  bool isCloudEnable = false;
  bool enabledInGameMusic = true;
  bool enabledGameSounds = true;
  bool isValidating = false;
  String inputValue = '';

  GlobalConfigProvider({
    required this.updateUserNameUseCase,
    required this.updateEmailUseCase,
    required this.updatePasswordUseCase,
    required this.deleteAccountUseCase,
    required this.validateCredentialsUseCase,
    required this.updateUserSettingsUseCase,
  });

  void initGlobalConfigValues(
      BuildContext context, UserSettingsModel userSettings) {
    currentGameMode = userSettings.gameMode;
    memorizingTime = userSettings.memorizingTime;
    isCloudEnable = userSettings.isCloudEnabled;
    enabledInGameMusic = userSettings.isInGameMusicEnabled;
    enabledGameSounds = userSettings.isGameSoundsEnabled;
  }

  void selectGameMode(BuildContext context, GameDifficulty selectedtGameMode) {
    currentGameMode = selectedtGameMode;
    Provider.of<GameProvider>(context, listen: false)
        .getGameMode(currentGameMode);

    notifyListeners();
  }

  setMemorizingTime(BuildContext context, int time) {
    if (time >= 3) {
      memorizingTime = time;
      Provider.of<GameProvider>(context, listen: false).getCountDownTime(time);
    }
    notifyListeners();
  }

  setCloudUpload(BuildContext context, bool value) {
    isCloudEnable = value;
    Provider.of<GameProvider>(context, listen: false).cloudEnable(value);
    notifyListeners();
  }

  void getInputValue(String value) {
    inputValue = value;
  }

  void setInGameMusic(BuildContext context, bool option) {
    enabledInGameMusic = !enabledInGameMusic;
    AudioService().setInGameMusic();
    notifyListeners();
  }

  void setGameSounds(bool option) {
    AudioService().setGameSounds();
    enabledGameSounds = !enabledGameSounds;
    notifyListeners();
  }

  void verifyCredentialsDialog(BuildContext context, AccountOption option) {
    showDialog(
      context: context,
      builder: (context) => CustomVerifyCredentialsDialog(
        actionButton: () => validateCredentials(context, option),
        getInputValue: (value) => getInputValue(value),
      ),
    );
  }

  void validateCredentials(BuildContext context, AccountOption option) async {
    if (isValidating) return;
    isValidating = true;
    final result = await validateCredentialsUseCase(inputValue);
    result.fold(
      (l) {
        InAppNotification.serverFailure(
          context: context,
          message: l.message,
        );
      },
      (r) {
        if (r) {
          switch (option) {
            case AccountOption.updateName:
              context.pop();
              showDialog(
                context: context,
                builder: (context) => StatefulBuilder(
                  builder: (context, setState) => CustomInputDialog(
                      title: 'Update User Name',
                      titleIcon: Icons.person,
                      message:
                          'Hi ${AuthService.userData!.name}, please, enter your new nickname.',
                      inputIcon: Icons.person,
                      hideText: 'NickName',
                      actionButtonIcon: Icons.send,
                      actionButtonTitle: 'Update',
                      actionButton: () => updateUserName(context, setState),
                      getInputValue: (value) => getInputValue(value)),
                ),
              );
              break;
            case AccountOption.updateEmail:
              context.pop();
              showDialog(
                context: context,
                builder: (context) => CustomInputDialog(
                    title: 'Update Email',
                    titleIcon: Icons.email,
                    message:
                        'Hi ${AuthService.userData!.name}, please, enter the new email address.',
                    inputIcon: Icons.email,
                    hideText: 'Email',
                    actionButtonIcon: Icons.send,
                    actionButtonTitle: 'Update',
                    actionButton: () => updateEmail(context, inputValue),
                    getInputValue: (value) => getInputValue(value)),
              );
              break;
            case AccountOption.updatePassword:
              //CustomInputDialog(title: 'Update Password', message: 'Please, enter the new password', inputIcon: inputIcon, hideText: hideText, actionButtonTitle: actionButtonTitle, actionButton: actionButton, getInputValue: getInputValue)
              break; //DIALOG
            case AccountOption.deleteAccount:
              context.pop();
              deleteAccountConfirmationDialog(context);
              break;
            default:
          }
        } else {
          InAppNotification.showAppNotification(
              context: context,
              title: 'Crenditials not found',
              message:
                  'Your user credentials were not found, please login again or try again.',
              type: NotificationType.warning);
        }
      },
    );
    isValidating = false;
  }

  void updateUserName(BuildContext context, StateSetter setState) async {
    if (inputValue.isEmpty || inputValue.length > 25) return;
    if (inputValue == AuthService.userData!.name) {
      InAppNotification.showAppNotification(
          title: 'You are already using this username',
          context: context,
          message: '$inputValue is your current user name!',
          type: NotificationType.warning);
      return;
    }
    loadingDialog(context);
    final result = await updateUserNameUseCase(inputValue);
    result.fold((l) {
      InAppNotification.serverFailure(
        context: context,
        message: l.message,
      );
    }, (r) {
      if (r) {
        context.pop();
        setState(() {});
        return InAppNotification.showAppNotification(
            context: context,
            title: successTitle,
            message: successMessage,
            type: successType);
      }
      InAppNotification.showAppNotification(
          context: context,
          title: failTitle,
          message: failMessage,
          type: failType);
    });
  }

  void updateEmail(BuildContext context, String email) async {
    if (inputValue.isEmpty ||
        !AppConstans.emailRegExp.hasMatch(inputValue.toLowerCase())) {
      InAppNotification.showAppNotification(
          title: 'Incorrect email format',
          context: context,
          message: 'Please, enter a valid email format',
          type: NotificationType.warning);
      return;
    }
    if (inputValue == AuthService.userData!.email) {
      InAppNotification.showAppNotification(
          title: 'You are already using this email address',
          context: context,
          message: '$inputValue is your current email address!',
          type: NotificationType.warning);
      return;
    }

    final result = await updateEmailUseCase(email.toLowerCase());
    result.fold(
      (l) {
        InAppNotification.serverFailure(
          context: context,
          message: l.message,
        );
      },
      (r) {
        if (r) {
          context.pop();
          return InAppNotification.showAppNotification(
              context: context,
              title: successTitle,
              message: successMessage,
              type: successType);
        }
        InAppNotification.showAppNotification(
            context: context,
            title: failTitle,
            message: failMessage,
            type: failType);
      },
    );
  }

  void updatePassword(BuildContext context, String password) async {
    if (inputValue.isEmpty) return;

    final result = await updatePasswordUseCase(password);
    result.fold(
      (l) {
        InAppNotification.serverFailure(
          context: context,
          message: l.message,
        );
      },
      (r) {
        if (r) {
          context.pop();
          return InAppNotification.showAppNotification(
              context: context,
              title: successTitle,
              message: successMessage,
              type: successType);
        }
        InAppNotification.showAppNotification(
            context: context,
            title: failTitle,
            message: failMessage,
            type: failType);
      },
    );
  }

  void deleteAccountConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return CustomConfirmationDialog(
          title: 'Delete Account',
          titleIcon: Icons.person_off,
          message:
              'You will not be able to revert this action, your personal data, game scores and other files will be deleted. Are you sure to continue?',
          mainAction: () {
            deleteAccount(context);
          },
        );
      },
    );
  }

  void deleteAccount(BuildContext context) async {
    final result = await deleteAccountUseCase(NoParams());
    result.fold(
      (l) {
        InAppNotification.serverFailure(
          context: context,
          message: l.message,
        );
      },
      (r) async {
        if (r) {
          InAppNotification.showAppNotification(
              context: context,
              title: 'Account successfully deleted',
              message:
                  'Hi ${AuthService.userData!.name}, your account has been deleted, we hope to see you again soon. -Memory Game Team.',
              type: successType);
          await Future.delayed(const Duration(seconds: 4))
              .then((value) => GoRouter.of(context).pushReplacement('/login'));
        } else {
          InAppNotification.showAppNotification(
              context: context,
              title: failTitle,
              message: failMessage,
              type: failType);
        }
      },
    );
  }

  void loadingDialog(BuildContext context) {
    showDialog(
      barrierDismissible: true,
      barrierColor: AppColors.disabled.withOpacity(0.5),
      context: context,
      builder: (context) => const Center(
        heightFactor: 1,
        child: CircularProgressIndicator(
          color: AppColors.text,
        ),
      ),
    );
  }

  void updateUserSettings() async {
    final currentUser = AuthService.currentUser;
    if (currentUser != null) {
      final UserSettingsModel userSettings = UserSettingsModel(
        userId: currentUser.uid,
        gameMode: currentGameMode,
        memorizingTime: memorizingTime,
        isCloudEnabled: isCloudEnable,
        isGameSoundsEnabled: enabledGameSounds,
        isInGameMusicEnabled: enabledInGameMusic,
      );
      if (!checkForChanges(userSettings)) return;
      final result = await updateUserSettingsUseCase(userSettings);
      result.fold(
          (l) => /*InAppNotification.serverFailure(
              context: context, message: l.message)*/
              print(l.message), (r) {
        if (r) {
          /*InAppNotification.showAppNotification(
              context: context,
              title: 'Updated game settings!',
              message: 'The game configuration has been successfully updated',
              type: NotificationType.success);*/
          print('The game configuration has been successfully updated');
        }
      });
    }
  }

  bool checkForChanges(UserSettingsModel newUserSettings) {
    if (AuthService.userSettings == null) return true;
    final UserSettingsModel currenSettings = AuthService.userSettings!;

    if (currenSettings.gameMode == newUserSettings.gameMode &&
        currenSettings.memorizingTime == newUserSettings.memorizingTime &&
        currenSettings.isCloudEnabled == newUserSettings.isCloudEnabled &&
        currenSettings.isInGameMusicEnabled ==
            newUserSettings.isInGameMusicEnabled &&
        currenSettings.isGameSoundsEnabled ==
            newUserSettings.isGameSoundsEnabled) {
      return false;
    }
    return true;
  }

  void backToHome(BuildContext context) {
    updateUserSettings();
    context.pop();
  }
}

enum AccountOption {
  updateName,
  updateEmail,
  updatePassword,
  deleteAccount,
}

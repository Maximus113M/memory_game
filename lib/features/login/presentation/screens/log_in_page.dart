import 'package:flutter/material.dart';
import 'package:memory_game/config/utils/utils.dart';

import 'package:memory_game/features/login/presentation/providers/log_in_provider.dart';
import 'package:memory_game/features/login/presentation/widgets/log_in_body.dart';

import 'package:provider/provider.dart';

class LogInPage extends StatelessWidget {
  static const name = '/login';

  const LogInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.contrast,
      body: LogInBody(logInProvider: Provider.of<LogInProvider>(context)),
    );
  }
}

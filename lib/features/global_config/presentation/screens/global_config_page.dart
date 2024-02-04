import 'package:flutter/material.dart';

import 'package:memory_game/core/utils/utils.dart';
import 'package:memory_game/features/global_config/presentation/widgets/global_config_page_body.dart';
import 'package:memory_game/features/global_config/presentation/providers/global_config_provider.dart';

import 'package:provider/provider.dart';

class GlobalConfigPage extends StatelessWidget {
  static const name = '/global-config';

  const GlobalConfigPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.text,
        elevation: 10,
        shadowColor: AppColors.text,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.contrast,
          ),
          onPressed: () =>
              context.read<GlobalConfigProvider>().backToHome(context),
        ),
        title: Row(
          children: [
            Text(
              'Configuration',
              style: FontStyles.subtitle2(AppColors.contrast),
            ),
          ],
        ),
      ),
      body: GlobalConfigPageBody(
          globalConfigProvider: Provider.of<GlobalConfigProvider>(context)),
    );
  }
}

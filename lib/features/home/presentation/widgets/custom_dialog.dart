import 'package:flutter/material.dart';

import 'package:memory_game/core/utils/utils.dart';
import 'package:memory_game/core/shared/widgets/buttons/custom_filled_buttons.dart';

class CustomDialog extends StatelessWidget {
  final int attempts;

  const CustomDialog({super.key, required this.attempts});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: ScreenSize.height * 0.51,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Text(
                'Well Done. You Won!',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const Divider(
                thickness: 2,
              ),
              const SizedBox(height: 10),
              Text('Game won with $attempts attempts'),
              const SizedBox(height: 20),
              SizedBox(
                height: ScreenSize.height * 0.25,
                width: ScreenSize.height * 0.25,
                child: Image.asset(
                  AppAssets.bmo,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomFilledButton(
                text: 'Ok',
                onPress: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

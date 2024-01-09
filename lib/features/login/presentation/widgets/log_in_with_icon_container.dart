import 'package:flutter/material.dart';
import 'package:memory_game/config/utils/utils.dart';

class LogInWithIconContainer extends StatelessWidget {
  final String imagePath;
  final double imageSize;
  final double padding;
  final Color? borderColor;

  const LogInWithIconContainer({
    super.key,
    required this.imagePath,
    required this.imageSize,
    required this.padding,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
          color: borderColor ?? AppColors.defaultBackGround,
          border: Border.all(color: AppColors.disabled),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: AppShadows.mainShadow),
      child: Image.asset(
        imagePath,
        height: imageSize,
      ),
    );
  }
}

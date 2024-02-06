import 'package:flutter/material.dart';
import 'package:memory_game/core/utils/utils.dart';

class CardBody extends StatelessWidget {
  final IconData? icon;
  final Color? cardColor;
  final Color? iconColor;
  final bool? isFound;
  const CardBody(
      {super.key, this.icon, this.cardColor, this.iconColor, this.isFound});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(width: 1),
          color: (isFound == null)
              ? AppColors.text
              : isFound!
                  ? Colors.yellow.shade600
                  : AppColors.contrast,
          boxShadow: AppShadows.mainShadow),
      child: Icon(
        icon ?? Icons.question_mark_outlined,
        color: (isFound == null)
            ? AppColors.contrast
            : isFound!
                ? AppColors.contrast
                : AppColors.text,
        size: 40,
      ),
    );
  }
}

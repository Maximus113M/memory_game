import 'package:flutter/material.dart';

class CardBody extends StatelessWidget {
  final IconData? icon;
  final Color? cardColor;
  final Color? iconColor;
  const CardBody({super.key, this.icon, this.cardColor, this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(width: 1),
          color: cardColor ?? Colors.black,
          boxShadow: const <BoxShadow>[
            BoxShadow(
              blurRadius: 8,
              color: Colors.black26,
              offset: Offset(2, 2),
            ),
          ]),
      child: Icon(
        icon ?? Icons.question_mark_outlined,
        color: iconColor ?? Colors.white,
        size: 40,
      ),
    );
  }
}

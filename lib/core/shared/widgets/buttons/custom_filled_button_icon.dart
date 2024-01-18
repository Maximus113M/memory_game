import 'package:flutter/material.dart';

class CustomFilledButtonIcon extends StatelessWidget {
  final Function() onPress;
  final String text;
  final IconData icon;
  final double? textSize;
  final double? iconSize;

  const CustomFilledButtonIcon(
      {super.key,
      required this.onPress,
      required this.text,
      required this.icon,
      this.textSize,
      this.iconSize});

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: onPress,
      icon: Icon(
        icon,
        size: iconSize ?? 30,
      ),
      label: Text(
        text,
        style: TextStyle(fontSize: textSize ?? 20),
      ),
      style: ButtonStyle(
        backgroundColor: const MaterialStatePropertyAll(Colors.black),
        shape: MaterialStatePropertyAll(
          ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        padding: const MaterialStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        ),
      ),
    );
  }
}

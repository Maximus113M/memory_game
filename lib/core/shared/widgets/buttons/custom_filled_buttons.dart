import 'package:flutter/material.dart';

class CustomFilledButton extends StatelessWidget {
  final Function() onPress;
  final String text;
  final TextStyle? textStyle;
  final Color? buttonColor;
  final double? verticalPadding;
  final double? horizontalPadding;

  const CustomFilledButton({
    super.key,
    required this.text,
    required this.onPress,
    this.textStyle,
    this.buttonColor,
    this.verticalPadding,
    this.horizontalPadding,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPress,
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(buttonColor ?? Colors.black),
        shape: const MaterialStatePropertyAll(
          ContinuousRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(18),
            ),
          ),
        ),
        padding: MaterialStatePropertyAll(EdgeInsets.symmetric(
            vertical: verticalPadding ?? 10,
            horizontal: horizontalPadding ?? 24)),
      ),
      child: Text(
        text,
        style: textStyle ?? const TextStyle(color: Colors.white),
      ),
    );
  }
}
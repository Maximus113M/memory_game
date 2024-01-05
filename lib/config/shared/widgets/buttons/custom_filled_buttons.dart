import 'package:flutter/material.dart';

class CustomFilledButton extends StatelessWidget {
  final Function() onPress;
  final String text;
  const CustomFilledButton({
    super.key,
    required this.text,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPress,
      style: const ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(Colors.black),
        shape: MaterialStatePropertyAll(
          ContinuousRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(18),
            ),
          ),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

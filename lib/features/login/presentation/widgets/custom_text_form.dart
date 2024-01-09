import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool showPassword;
  final bool isHiden;
  final Function()? toggleVisibility;
  const CustomTextForm(
      {super.key,
      required this.icon,
      required this.text,
      required this.showPassword,
      this.toggleVisibility,
      this.isHiden = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
          prefixIcon: Icon(icon),
          suffixIcon: showPassword
              ? IconButton(
                  onPressed: () => toggleVisibility!(),
                  icon: const Icon(Icons.remove_red_eye_outlined),
                )
              : null,
          hintText: text),
      obscureText: isHiden,
    );
  }
}

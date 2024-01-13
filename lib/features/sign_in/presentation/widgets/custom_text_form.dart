import 'package:flutter/material.dart';

import 'package:memory_game/core/utils/utils.dart';

class CustomTextForm extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool showPassword;
  final bool isHiden;
  final bool error;
  final Function(String value) onChange;
  final Function()? toggleVisibility;
  const CustomTextForm({
    super.key,
    required this.icon,
    required this.text,
    required this.showPassword,
    required this.onChange,
    required this.error,
    this.toggleVisibility,
    this.isHiden = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.contrast,
        boxShadow: AppShadows.mainShadow,
      ),
      child: TextFormField(
        decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
            prefixIcon:
                Icon(icon, color: error ? AppColors.errorText : AppColors.text),
            suffixIcon: showPassword
                ? IconButton(
                    onPressed: () => toggleVisibility!(),
                    icon: const Icon(Icons.remove_red_eye_outlined),
                  )
                : null,
            hintText: text),
        obscureText: isHiden,
        onChanged: (value) => onChange(value),
        style:
            TextStyle(color: error ? AppColors.errorText : AppColors.lightText),
      ),
    );
  }
}

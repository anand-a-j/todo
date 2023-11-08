import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool enableSuffixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onPressed;
  const CustomTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.enableSuffixIcon = false,
      this.suffixIcon,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        isDense: true,
        hintText: hintText,
        border: OutlineInputBorder(
          borderSide: const BorderSide(width: 0.8, color: Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),
        suffixIcon: enableSuffixIcon
            ? IconButton(
                onPressed: onPressed,
                icon: const Icon(
                  Icons.calendar_month,
                ),
              )
            : null,
      ),
    );
  }
}

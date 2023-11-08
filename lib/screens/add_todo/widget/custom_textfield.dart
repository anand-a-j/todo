import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool enableSuffixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onPressed;
  final bool readOnly;
  const CustomTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.enableSuffixIcon = false,
      this.suffixIcon,
      this.onPressed,
      this.readOnly = false,
      });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: TextField(
        autofocus: false,
        controller: controller,
        readOnly: readOnly,
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
                  icon: Icon(
                    suffixIcon,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}

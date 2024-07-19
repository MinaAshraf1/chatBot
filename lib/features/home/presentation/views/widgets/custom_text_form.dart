import 'package:chat_bot/core/utils/styles.dart';
import 'package:chat_bot/main.dart';
import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  final TextEditingController textEditingController;
  final void Function()? onPressIcon;
  final IconData icon;

  const CustomTextForm({
    super.key,
    required this.textEditingController,
    required this.onPressIcon,
    required this.icon
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      minLines: 1,
      maxLines: 3,
      style: const TextStyle(
        color: Colors.black
      ),
      decoration: InputDecoration(
        hintText: "Write to chat",
        hintStyle: Styles.testStyle16,
        suffixIcon: IconButton(
          onPressed: onPressIcon,
          color: const Color(0xff2E1B38),
          icon: Icon(icon),
        ),
        fillColor: prefs.getBool("darkMode") == true
          ? const Color(0xffF4EEFA) : const Color(0xffD3AFD0),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none
        )
      ),
    );
  }

}
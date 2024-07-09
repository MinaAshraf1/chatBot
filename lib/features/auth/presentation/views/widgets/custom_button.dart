import 'package:chat_bot/core/utils/styles.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final void Function() onPressed;

  const CustomButton({super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      padding: const EdgeInsets.all(10),
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15)
      ),
      color: const Color(0xff2E1B38),
      child: Text(title, style: Styles.testStyle20,),
    );
  }

}
import 'package:chat_bot/core/utils/styles.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final String textButton;
  final void Function()? onPressed;

  const CustomText({
    super.key,
    required this.text, required
    this.textButton,
    this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("$text "),

        TextButton(
          onPressed: onPressed,
          child: Text(
            textButton,
            style: Styles.testStyle14,
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }

}
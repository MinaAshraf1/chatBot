import 'package:chat_bot/core/utils/styles.dart';
import 'package:flutter/material.dart';

class ForgetPasswordButton extends StatelessWidget {
  const ForgetPasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),

        MaterialButton(
          onPressed: () {
            Navigator.of(context).pushNamed("forgetPassword");
          },
          child: const Text(
            "Forget Password?",
            style: Styles.testStyle14,
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }

}
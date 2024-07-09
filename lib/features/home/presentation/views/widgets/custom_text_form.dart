import 'package:chat_bot/core/utils/styles.dart';
import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  final TextEditingController textEditingController;
  final void Function()? onPressIcon;
  final bool enabled;

  const CustomTextForm({
    super.key,
    required this.textEditingController,
    required this.onPressIcon,
    required this.enabled
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      minLines: 1,
      maxLines: 3,
      enabled: enabled,
      decoration: InputDecoration(
        hintText: "Write to chat",
        hintStyle: Styles.testStyle16,
        suffixIcon: IconButton(
          onPressed: onPressIcon,
          color: const Color(0xff2E1B38),
          icon: const Icon(Icons.send,),
        ),
        fillColor: const Color(0xffD3AFD0),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none
        )
      ),
    );
  }

}
import 'package:chat_bot/core/utils/styles.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final IconData? icon;
  final TextEditingController textEditingController;
  final bool isPass;
  final bool? hidePass;
  final void Function()? onPressIcon;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final String? changeText;
  final Color? color;

  const CustomTextField({
    super.key,
    required this.title,
    this.icon,
    required this.textEditingController,
    required this.isPass,
    this.hidePass,
    this.onPressIcon,
    this.validator,
    this.onChanged, this.changeText, this.color
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15,),

        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(title, style: Styles.testStyle18, ),
        ),

        TextFormField(
          controller: textEditingController,
          validator: validator,
          onChanged: onChanged,
          obscureText: isPass? hidePass! : false,
          decoration: InputDecoration(
            hintText: "Enter your $title",
            prefixIcon: Icon(icon,),
            suffixIcon: isPass? IconButton(
              onPressed: onPressIcon,
              icon: Icon(
                hidePass!? Icons.visibility_off_outlined :Icons.visibility_outlined,
              ),
            ) : null,
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15)
            )
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            changeText ?? "",
            style: TextStyle(
              color: color
            ),
          ),
        )
      ],
    );
  }

}
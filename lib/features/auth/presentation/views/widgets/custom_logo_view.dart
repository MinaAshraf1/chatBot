import 'package:chat_bot/core/utils/assets.dart';
import 'package:chat_bot/core/utils/styles.dart';
import 'package:flutter/material.dart';

class CustomLogoView extends StatelessWidget {
  final String title;
  final String description;

  const CustomLogoView({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 150,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0x346D1ACB),
            borderRadius: BorderRadius.circular(200)
          ),
          child: Image.asset(Assets.logo,),
        ),

        FittedBox(child: Text(title, style: Styles.testStyle40,)),

        Text(description, style: Styles.testStyle14, ),
      ],
    );
  }

}
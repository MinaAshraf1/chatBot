import 'package:chat_bot/core/utils/assets.dart';
import 'package:flutter/material.dart';

class CustomLogo extends StatelessWidget {
  const CustomLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: const Color(0x346D1ACB),
          borderRadius: BorderRadius.circular(200)
      ),
      child: Image.asset(Assets.logo,),
    );
  }

}
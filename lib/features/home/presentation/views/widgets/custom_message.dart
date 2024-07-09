import 'package:chat_bot/core/utils/styles.dart';
import 'package:flutter/material.dart';

class CustomMessage extends StatelessWidget {
  final String sentMsg;
  final String botMsg;

  const CustomMessage({super.key, required this.sentMsg, required this.botMsg});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 300
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: const BoxDecoration(
                  color: Color(0xff2E1B38),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30)
                  )
                ),
                child: Text(
                  sentMsg,
                  style: Styles.testStyle18.copyWith(color: const Color(0xffF4EEFA)),
                )
              ),
            )
          ],
        ),

        const SizedBox(height: 10,),

        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 300
              ),
              child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: const BoxDecoration(
                      color: Color(0xffD3AFD0),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30)
                      )
                  ),
                child: Text(
                  botMsg,
                  style: Styles.testStyle18.copyWith(color: const Color(0xff2E1B38))
                )
              ),
            )
          ],
        ),

        const SizedBox(height: 10,),
      ],
    );
  }

}
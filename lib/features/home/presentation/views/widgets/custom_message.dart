import 'package:chat_bot/core/utils/styles.dart';
import 'package:chat_bot/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_plus/share_plus.dart';

class CustomMessage extends StatelessWidget {
  final String sentMsg;
  final String botMsg;

  const CustomMessage({
    super.key,
    required this.sentMsg,
    required this.botMsg,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 275
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: prefs.getBool("darkMode") == true
                      ? const Color(0xffF4EEFA) : const Color(0xff2E1B38),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30)
                  )
                ),
                child: InkWell(
                  onLongPress: () {
                    Clipboard.setData(ClipboardData(text: sentMsg));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Copied to clipboard')),
                    );
                  },
                  child: Text(
                    sentMsg,
                    style: prefs.getBool("darkMode") == true
                        ? Styles.testStyle18.copyWith(color: const Color(0xff2E1B38))
                        : Styles.testStyle18.copyWith(color: const Color(0xffF4EEFA)),
                  ),
                )
              ),
            ),
          ],
        ),

        const SizedBox(height: 10,),

        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                Share.share(botMsg);
              },
              child: FaIcon(
                FontAwesomeIcons.robot,
                // size: 18,
                color: prefs.getBool("darkMode") == true
                    ? const Color(0xffF4EEFA) : const Color(0xff2E1B38),
              ),
            ),

            const SizedBox(width: 7,),

            ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 275
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
                child: InkWell(
                  onLongPress: () {
                    Clipboard.setData(ClipboardData(text: botMsg));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Copied to clipboard')),
                    );
                  },
                  child: Text(
                    botMsg,
                    style: Styles.testStyle18.copyWith(color: const Color(0xff2E1B38))
                  ),
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
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chat_bot/core/utils/styles.dart';
import 'package:chat_bot/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xff2E1B38),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 75),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Settings",
              style: Styles.testStyle24.copyWith(
                  letterSpacing: 2
              ),
              textAlign: TextAlign.left,
            ),

            const SizedBox(height: 40,),

            SwitchListTile(
              onChanged: (val){
                prefs.setBool("darkMode", val);
                val = !val;
                setState(() {

                });
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.info,
                  animType: AnimType.bottomSlide,
                  title: 'Notice',
                  desc: "Please restart app to change mode",
                  btnCancelOnPress: () {},
                  btnOkOnPress: () {
                    SystemNavigator.pop();
                  },
                ).show();
              },
              contentPadding: EdgeInsets.zero,
              title: Row(
                children: [
                  const Icon(
                    Icons.dark_mode_rounded,
                    color: Color(0xffF4EEFA),
                    size: 30,
                  ),
                  const SizedBox(width: 5,),
                  Text("Dark Mode",
                    style: Styles.testStyle20.copyWith(
                        fontWeight: FontWeight.w400
                    ),
                  ),
                ],
              ),
              value: prefs.getBool("darkMode") == true? true : false,
            ),

            const SizedBox(height: 40,),

            MaterialButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                prefs.setBool("logged", false);
                Navigator.of(context).pushNamedAndRemoveUntil("login", (route) => false,);
              },
              padding: const EdgeInsets.all(7),
              shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none
              ),
              color: const Color(0xffF4EEFA),
              child: Text("Logout",
                style: Styles.testStyle24.copyWith(
                    color: const Color(0xff1B2539)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
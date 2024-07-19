import "dart:io";

import "package:chat_bot/core/utils/constant.dart";
import "package:chat_bot/features/auth/presentation/cubit/auth_cubit.dart";
import "package:chat_bot/features/auth/presentation/views/forget_password.dart";
import "package:chat_bot/features/auth/presentation/views/login.dart";
import "package:chat_bot/features/auth/presentation/views/register.dart";
import "package:chat_bot/features/home/presentation/cubit/message_cubit.dart";
import "package:chat_bot/features/home/presentation/views/home.dart";
import "package:flutter/material.dart";
import 'package:firebase_core/firebase_core.dart';
import "package:flutter_bloc/flutter_bloc.dart";
import "package:shared_preferences/shared_preferences.dart";

late SharedPreferences prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  Platform.isAndroid
      ? await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBYQvNPOTOZHFwcMEUFYjlV-Zpe9tPhcdI",
      appId: "1:982757879404:android:37aca35cf104bc1875b249",
      messagingSenderId: "982757879404",
      projectId: "chatbot-a543e",
    ),
  )
      : await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    prefs.getBool("darkMode") == null 
        ? MediaQuery.of(context).platformBrightness == Brightness.dark 
        ? prefs.setBool("darkMode", true): prefs.setBool("darkMode", false) 
        : null;
    
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit(),),
        BlocProvider(create: (context) => MessageCubit(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: prefs.getBool("logged") == true? const Home() : const Login(),
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: colorsLight['color1'],
        ),
        darkTheme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: colorsDark['color1'],
        ),
        themeMode: prefs.getBool("darkMode") == true
            ? ThemeMode.dark : ThemeMode.light,
        routes: {
          "register": (context) => const Register(),
          "login": (context) => const Login(),
          "forgetPassword": (context) => const ForgetPassword(),
          "home": (context) => const Home(),
        },
      )
    );
  }
}
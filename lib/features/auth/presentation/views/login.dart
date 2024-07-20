import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chat_bot/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:chat_bot/features/auth/presentation/cubit/auth_state.dart';
import 'package:chat_bot/features/auth/presentation/views/widgets/custom_button.dart';
import 'package:chat_bot/features/auth/presentation/views/widgets/custom_logo_view.dart';
import 'package:chat_bot/features/auth/presentation/views/widgets/custom_text.dart';
import 'package:chat_bot/features/auth/presentation/views/widgets/custom_text_field.dart';
import 'package:chat_bot/features/auth/presentation/views/widgets/forget_password_button.dart';
import 'package:chat_bot/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login extends StatefulWidget {

  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController email;
  late TextEditingController password;
  bool hidePass = true;
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;

  @override
  void initState() {
    email = TextEditingController();
    password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    email.dispose();
    password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if(state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSuccess) {
          isLoading = false;
          prefs.setStringList("userMsg", []);
          prefs.setStringList("botMsg", []);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("logging in success"),
            duration: Duration(seconds: 1),
          ));
          Navigator.of(context).pushReplacementNamed("home");
        } else if(state is LoginFailure){
          isLoading = false;
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.bottomSlide,
            title: 'Error',
            desc: state.errors,
            btnCancelOnPress: () {},
            btnOkOnPress: () {},
          ).show();
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50),
            children: [
              const CustomLogoView(
                title: "Login",
                description: "Let's Get Started",
              ),

              const SizedBox(height: 50,),

              Form(
                key: formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      title: "Email",
                      icon: Icons.email_outlined,
                      textEditingController: email,
                      isPass: false,
                      validator: (val) {
                        if(val!.isEmpty) {
                          return "Can't send empty email";
                        }
                        return null;
                      },
                    ),

                    CustomTextField(
                      title: "Password",
                      icon: Icons.lock_outline_rounded,
                      textEditingController: password,
                      isPass: true,
                      hidePass: hidePass,
                      onPressIcon: () {
                        hidePass = !hidePass;
                        setState(() {

                        });
                      },
                      validator: (val) {
                        if(val!.isEmpty) {
                          return "Can't send empty password";
                        }
                        return null;
                      },
                    ),
                  ],
                )
              ),

              const ForgetPasswordButton(),

              const SizedBox(height: 20,),

              isLoading? const Center(child: CircularProgressIndicator(),)
              : CustomButton(
                onPressed: () {
                  BlocProvider.of<AuthCubit>(context).login(formKey, email.text, password.text);
                },
                title: "Login"
              ),

              const SizedBox(height: 20,),

              CustomText(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed("register");
                },
                text: "Don't have an account?",
                textButton: "Sign up"
              )
            ],
          ),
        );
      }
    );
  }
}
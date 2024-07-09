import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chat_bot/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:chat_bot/features/auth/presentation/cubit/auth_state.dart';
import 'package:chat_bot/features/auth/presentation/views/widgets/custom_button.dart';
import 'package:chat_bot/features/auth/presentation/views/widgets/custom_logo_view.dart';
import 'package:chat_bot/features/auth/presentation/views/widgets/custom_text.dart';
import 'package:chat_bot/features/auth/presentation/views/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Register extends StatefulWidget {

  const Register({super.key});

  @override
  State<Register> createState() => _Register();
}

class _Register extends State<Register> {
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController confirmPassword;
  bool hidePass = true;
  bool hidePass1 = true;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;
  String? changePassword1;
  String? changePassword2;
  Color colorChange1 = Colors.green;
  Color? colorChange2 = Colors.green;

  @override
  void initState() {
    email = TextEditingController();
    password = TextEditingController();
    confirmPassword = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if(state is RegisterLoading) {
          isLoading = true;
        } else if(state is RegisterSuccess) {
          isLoading = false;
          AwesomeDialog(
            context: context,
            dialogType: DialogType.info,
            animType: AnimType.bottomSlide,
            title: 'Verify email',
            desc: "we send email verification, please verify email",
            btnCancelOnPress: () {},
            btnOkOnPress: () {
              Navigator.of(context).pushReplacementNamed("login");
            },
          ).show();
        } else if(state is RegisterFailure){
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
                title: "Register",
                description: "Let's Get Started",
              ),

              const SizedBox(height: 30,),

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
                      changeText: changePassword1,
                      color: colorChange1,
                      validator: (val) {
                        bool hasUpperCase = val!.contains(RegExp(r'[A-Z]'));
                        bool hasLowerCase = val.contains(RegExp(r'[a-z]'));
                        bool hasNumber = val.contains(RegExp(r'[0-9]'));
                        if (val.isEmpty) {
                          return "can't send empty field";
                        } else if(!hasUpperCase) {
                          return "you should put capital letter";
                        } else if (!hasLowerCase) {
                          return "you should put small letter";
                        } else if (!hasNumber) {
                          return "you should put number";
                        }
                        return null;
                      },
                      onChanged: (val) {
                        bool hasUpperCase = val.contains(RegExp(r'[A-Z]'));
                        bool hasLowerCase = val.contains(RegExp(r'[a-z]'));
                        bool hasNumber = val.contains(RegExp(r'[0-9]'));
                        if(!hasUpperCase) {
                          changePassword1 = "you should put capital letter";
                          colorChange1 = Colors.red;
                          setState(() {

                          });
                        } else if (!hasLowerCase) {
                          changePassword1 =  "you should put small letter";
                          colorChange1 = Colors.red;
                          setState(() {

                          });
                        } else if (!hasNumber) {
                          changePassword1 = "you should put number";
                          colorChange1 = Colors.red;
                          setState(() {

                          });
                        } else {
                          changePassword1 = "Good Password";
                          colorChange1 = Colors.green;
                          setState(() {

                          });
                        }
                      },
                    ),

                    CustomTextField(
                      title: "Confirm Password",
                      icon: Icons.lock_outline_rounded,
                      textEditingController: confirmPassword,
                      isPass: true,
                      hidePass: hidePass1,
                      onPressIcon: () {
                        hidePass1 = !hidePass1;
                        setState(() {

                        });
                      },
                      color: colorChange2,
                      changeText: changePassword2,
                      onChanged: (val) {
                        if(val != password.text) {
                          changePassword2 = "Not Identical Password";
                          colorChange2 = Colors.red;
                          setState(() {

                          });
                        } else {
                          changePassword2 = "Identical Password";
                          colorChange2 = Colors.green;
                          setState(() {

                          });
                        }
                      },
                      validator: (val) {
                        if(val!.isEmpty) {
                          return "Can't send empty confirm password";
                        } else if(val != password.text) {
                          return "confirm password doesn't match with password";
                        }
                        return null;
                      },
                    ),
                  ],
                )
              ),

              const SizedBox(height: 30,),

              isLoading? const Center(child: CircularProgressIndicator())
              : CustomButton(
                onPressed: () {
                  BlocProvider.of<AuthCubit>(context).register(
                      formKey, email.text, password.text);
                },
                title: "Register"
              ),

              const SizedBox(height: 15,),

              CustomText(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed("login");
                },
                text: "Do you have an account?",
                textButton: "Login"
              )
            ],
          ),
        );
      }
    );
  }
}
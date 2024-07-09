import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chat_bot/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:chat_bot/features/auth/presentation/cubit/auth_state.dart';
import 'package:chat_bot/features/auth/presentation/views/widgets/custom_button.dart';
import 'package:chat_bot/features/auth/presentation/views/widgets/custom_logo_view.dart';
import 'package:chat_bot/features/auth/presentation/views/widgets/custom_text.dart';
import 'package:chat_bot/features/auth/presentation/views/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPassword extends StatefulWidget {

  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPassword();
}

class _ForgetPassword extends State<ForgetPassword> {
  late TextEditingController email;
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;

  @override
  void initState() {
    email = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    email.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState> (
      listener: (context, state) {
        if(state is ForgetLoading) {
          isLoading = true;
        } else if (state is ForgetSuccess) {
          isLoading = false;
          AwesomeDialog(
            context: context,
            dialogType: DialogType.info,
            animType: AnimType.bottomSlide,
            title: 'Send Reset Password Done',
            desc: "we sent reset password, please check email",
            btnCancelOnPress: () {},
            btnOkOnPress: () {
              Navigator.of(context).pushReplacementNamed("login");
            },
          ).show();
        } else if(state is ForgetFailure){
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
                title: "Forget Password",
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
                  ],
                )
              ),

              const SizedBox(height: 40,),

              isLoading? const Center(child: CircularProgressIndicator(),)
              : CustomButton(
                onPressed: () {
                  BlocProvider.of<AuthCubit>(context).forgetPassword(
                      formKey, email.text);
                },
                title: "Send Email"
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
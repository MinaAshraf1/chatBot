import 'package:chat_bot/features/auth/presentation/cubit/auth_state.dart';
import 'package:chat_bot/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(InitialState());

  Future<void> register(
      GlobalKey<FormState> formKey, String email, String password) async {
    if (formKey.currentState!.validate()) {
      emit(RegisterLoading());
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        FirebaseAuth.instance.currentUser!.sendEmailVerification();
        emit(RegisterSuccess());
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          emit(RegisterFailure('The password provided is too weak.'));
        } else if (e.code == 'email-already-in-use') {
          emit(RegisterFailure('The account already exists for that email.'));
        } else {
          emit(RegisterFailure(e.code.toString()));
        }
      } catch (e) {
        emit(RegisterFailure(e.toString()));
      }
    }
  }

  Future<void> login(
      GlobalKey<FormState> formKey, String email, String password) async {
    if (formKey.currentState!.validate()) {
      emit(LoginLoading());
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        if(FirebaseAuth.instance.currentUser!.emailVerified) {
          prefs.setBool("logged", true);
          emit(LoginSuccess());
        } else {
          emit(LoginFailure('please verify your email'));
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-email') {
          emit(LoginFailure('please write correct email.'));
        } else if (e.code == 'user-not-found') {
          emit(LoginFailure('No user found for that email.'));
        } else if (e.code == 'wrong-password') {
          emit(LoginFailure('Wrong password provided for that user.'));
        } else {
          emit(LoginFailure(e.code.toString()));
        }
      }
    }
  }

  Future<void> forgetPassword(GlobalKey<FormState> formKey, String email) async {
    if (formKey.currentState!.validate()) {
      emit(ForgetLoading());
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        emit(ForgetSuccess());
      } catch (e) {
        emit(ForgetFailure(e.toString()));
      }
    }
  }

}

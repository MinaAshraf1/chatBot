import 'package:chat_bot/features/home/presentation/cubit/message_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageCubit extends Cubit<MessageState> {
  MessageCubit(): super(InitialState());

  String msg = "";

  Future<void> messageBot(TextEditingController msgController) async {
    msg = msgController.text;
    msgController.text = "";
    emit(SentSuccess(msg));
    try {
      emit(MessageLoading());
      var response = await Dio().post(
        "https://chatbot-ra82.onrender.com",
        queryParameters: {
          "data": msg
        }
      );
      // getMessage.add(response.data['chatBot']);
      emit(MessageSuccess(response.data["chatBot"]));
    } catch(e) {
      // getMessage.add("please try again");
      emit(MessageFailure());
    }
  }
}
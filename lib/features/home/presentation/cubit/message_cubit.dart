import 'package:chat_bot/features/home/presentation/cubit/message_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageCubit extends Cubit<MessageState> {
  MessageCubit() : super(InitialState());

  bool messageCansel = false;

  Future<void> messageBot(String msg) async {
    emit(SentSuccess(msg));
    try {
      emit(MessageLoading());
      var response = await Dio().post(
          "https://chatbot-ra82.onrender.com",
          queryParameters: {
            "data": msg
          }
      );
      if(messageCansel) {
        emit(MessageCansel());
        messageCansel = !messageCansel;
      } else {
        emit(MessageSuccess(response.data["chatBot"]));
      }
    } catch (e) {
      emit(MessageFailure());
    }
  }
}
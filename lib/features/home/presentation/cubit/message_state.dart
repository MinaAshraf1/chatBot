abstract class MessageState {}

class InitialState extends MessageState {}

class SentSuccess extends MessageState {
  final String sentMsg;

  SentSuccess(this.sentMsg);
}

class MessageSuccess extends MessageState {
  final String getMsg;

  MessageSuccess(this.getMsg);
}

class MessageFailure extends MessageState {}

class MessageLoading extends MessageState {}
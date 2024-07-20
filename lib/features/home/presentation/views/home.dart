import 'package:chat_bot/core/utils/styles.dart';
import 'package:chat_bot/features/home/presentation/cubit/message_cubit.dart';
import 'package:chat_bot/features/home/presentation/cubit/message_state.dart';
import 'package:chat_bot/features/home/presentation/views/widgets/custom_drawer.dart';
import 'package:chat_bot/features/home/presentation/views/widgets/custom_logo.dart';
import 'package:chat_bot/features/home/presentation/views/widgets/custom_message.dart';
import 'package:chat_bot/features/home/presentation/views/widgets/custom_text_form.dart';
import 'package:chat_bot/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {

  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late TextEditingController message;
  late ScrollController _scrollController;
  List sentMsg = [];
  List getMsg = [];
  bool enabled = true;
  bool botLoading = false;

  @override
  void initState() {
    _scrollController = ScrollController();
    message = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    message.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MessageCubit, MessageState>(
      listener: (context, state) {
        if(state is SentSuccess) {
          enabled = false;
          message.text = "";
          sentMsg.add(state.sentMsg);
          getMsg.add("waiting...");
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 2),
              curve: Curves.easeOut,
            );
          });
        } else if (state is MessageSuccess) {
          enabled = true;
          getMsg[getMsg.length - 1] = state.getMsg;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 2),
              curve: Curves.easeOut,
            );
          });
        } else if(state is MessageFailure) {
          enabled = true;
          getMsg[getMsg.length - 1] = "please try again!";
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 2),
              curve: Curves.easeOut,
            );
          });
        } else if(state is MessageCansel) {
          enabled = true;
          getMsg[getMsg.length - 1] = "Cancel Message";
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 2),
              curve: Curves.easeOut,
            );
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Chat Bot",
              style: prefs.getBool("darkMode") == true
                  ? Styles.testStyle24.copyWith(color: const Color(0xff2E1B38))
                  : Styles.testStyle24.copyWith(color: const Color(0xffF4EEFA)),
            ),
            iconTheme: IconThemeData(
              size: 28,
              color: prefs.getBool("darkMode") == true
                  ? const Color(0xff2E1B38) : const Color(0xffF4EEFA),
            ),
            backgroundColor: prefs.getBool("darkMode") == true
                ? const Color(0xffD3AFD0) : const Color(0xff170E39),
            elevation: 3,
            shadowColor: const Color(0xffD3AFD0),
            actions: [
              IconButton(
                onPressed: () {
                  sentMsg.clear();
                  getMsg.clear();
                  setState(() {

                  });
                },
                iconSize: 24,
                icon: const Icon(Icons.add_comment_rounded),
              )
            ],
          ),
          drawer:  const CustomDrawer(),
          body: Padding(
            padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20, top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                sentMsg.isEmpty
                ? const Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomLogo(),
                    ],
                  ),
                )
                : Expanded(
                  child:
                      ListView.builder(
                        controller: _scrollController,
                        physics: const BouncingScrollPhysics(),
                        itemCount: sentMsg.length,
                        itemBuilder: (context, index) =>
                            CustomMessage(
                              sentMsg: sentMsg[index],
                              botMsg: getMsg[index],
                            )

                  ),
                ),

                const SizedBox(height: 5,),

                CustomTextForm(
                  onPressIcon: () {
                    enabled
                      ? BlocProvider.of<MessageCubit>(context).messageBot(message.text)
                      : BlocProvider.of<MessageCubit>(context).messageCansel = true;
                  },
                  icon: enabled? Icons.send : Icons.stop_circle_outlined,
                  textEditingController: message
                )
              ],
            ),
          ),
        );
      }
    );
  }
}
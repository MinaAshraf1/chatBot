import 'package:chat_bot/core/utils/styles.dart';
import 'package:chat_bot/features/home/presentation/cubit/message_cubit.dart';
import 'package:chat_bot/features/home/presentation/cubit/message_state.dart';
import 'package:chat_bot/features/home/presentation/views/widgets/custom_logo.dart';
import 'package:chat_bot/features/home/presentation/views/widgets/custom_message.dart';
import 'package:chat_bot/features/home/presentation/views/widgets/custom_text_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
          sentMsg.add(state.sentMsg);
          getMsg.add("waiting...");
          setState(() {

          });
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOut,
          );
        } else if (state is MessageSuccess) {
          enabled = true;
          getMsg[getMsg.length - 1] = state.getMsg;
          setState(() {

          });
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOut,
          );
        } else if(state is MessageFailure) {
          enabled = true;
          getMsg[getMsg.length - 1] = "please try again!";
          setState(() {

          });
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOut,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Chat Bot", style: Styles.testStyle24,),
            backgroundColor: const Color(0xff170E39),
            actions: [
              IconButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushNamedAndRemoveUntil("login", (route) => false,);
                },
                iconSize: 26,
                color: const Color(0xffE3DFDE),
                icon: const Icon(Icons.logout),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20, top: 20),
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

                const SizedBox(height: 20,),

                CustomTextForm(
                  onPressIcon: () {
                    BlocProvider.of<MessageCubit>(context).messageBot(message);
                  },
                  enabled: enabled,
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
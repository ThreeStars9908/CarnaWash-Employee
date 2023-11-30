import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../ui.dart';

class HelpChatPage extends StatefulWidget {
  const HelpChatPage({super.key});

  @override
  State<HelpChatPage> createState() => _HelpChatPageState();
}

class MessageModel {
  MessageModel({
    required this.text,
    required this.isMine,
  });

  String text;
  bool isMine;
}

class _HelpChatPageState extends State<HelpChatPage> {
  TextEditingController messageController = TextEditingController();
  List<MessageModel> messageList = [
    MessageModel(
      text: 'Olá!',
      isMine: true,
    ),
    MessageModel(
      text: 'Olá! Tudo bem?',
      isMine: false,
    ),
  ];

  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      bottomNavigationBar: navigationBarComponent(context),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 50,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            backButtonComponent(context),
                            const Text(
                              'Chat',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                        notificationGeralButtonComponent(context),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Container(
                  height: (MediaQuery.of(context).viewInsets.bottom == 0)
                      ? MediaQuery.of(context).size.height - 290
                      : MediaQuery.of(context).size.height - 530,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(245, 245, 245, 1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ListView.builder(
                      dragStartBehavior: DragStartBehavior.down,
                      controller: scrollController,
                      itemCount: messageList.length,
                      itemBuilder: (context, index) {
                        return Align(
                          alignment: (messageList[index].isMine)
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            constraints: BoxConstraints(
                              maxWidth:
                                  MediaQuery.of(context).size.width * 0.66,
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 24),
                            margin: const EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                              color: (messageList[index].isMine)
                                  ? Colors.green
                                  : Colors.white,
                              borderRadius: (messageList[index].isMine)
                                  ? const BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.circular(12),
                                      bottomLeft: Radius.circular(12),
                                    )
                                  : const BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.circular(12),
                                      bottomRight: Radius.circular(12),
                                    ),
                            ),
                            child: Text(
                              messageList[index].text,
                              style: TextStyle(
                                color: (messageList[index].isMine)
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  decoration: const BoxDecoration(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      chatTextInput(
                        context: context,
                        text: 'Write the message',
                        textController: messageController,
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            messageList.add(
                              MessageModel(
                                text: messageController.text,
                                isMine: true,
                              ),
                            );
                            messageController.text = '';
                          });
                        },
                        icon: const Icon(
                          Icons.send,
                          color: Color.fromRGBO(237, 189, 58, 1),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

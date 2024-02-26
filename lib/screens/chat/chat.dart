import 'package:flutter/material.dart';
import 'package:one_in_million/models/message_data_model.dart';
import 'package:one_in_million/models/message.dart';
import 'package:one_in_million/utils/colors.dart';

class ChatDashboard extends StatefulWidget {
  const ChatDashboard({super.key});

  @override
  ChatState createState() => ChatState();
}

class ChatState extends State<ChatDashboard> {
  TextEditingController messageEditingController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _needsScroll = false;

  final List<Message> listMessage = [];

  Widget chatMessages() {
    return ListView.builder(
      itemCount: listMessage.length,
      controller: _scrollController,
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.only(bottom: 80),
      itemBuilder: (context, index) {
        return MessageTile(message: listMessage[index].message!, sendByMe: listMessage[index].isBot!);
      },
    );
  }

  addMessage() {
    if (messageEditingController.text.isNotEmpty) {
      listMessage.add(Message(message: messageEditingController.text, isBot: false));
      String messageBot = MessageData.getMessageBot(messageEditingController.text);
      listMessage.add(Message(message: messageBot, isBot: true));
      setState(() {
        messageEditingController.text = "";
        _needsScroll = true;
      });
    }
  }

  _scrollToEnd() async {
    if (_needsScroll) {
      _needsScroll = false;
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
    }
  }

  @override
  void initState() {
    super.initState();
    messageEditingController.addListener(() {
      _needsScroll = true;
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollToEnd);
    messageEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToEnd());
    return Material(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Center(
            child: Text(
          'ChatBot',
          style: TextStyle(color: Colors.black),
        )),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: const [
          Icon(
            Icons.menu,
            color: Colors.white,
          )
        ],
      ),
      body: SizedBox(
        child: Stack(
          children: [
            chatMessages(),
            Container(
              alignment: Alignment.bottomCenter,
              width: MediaQuery.of(context).size.width,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                color: AppColor.iconBlue,
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                      onTap: () {
                        setState(() {
                          _needsScroll = true;
                        });
                      },
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                      cursorColor: Colors.white,
                      controller: messageEditingController,
                      decoration: const InputDecoration(
                          hintText: "Aa",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                          border: InputBorder.none),
                    )),
                    const SizedBox(
                      width: 16,
                    ),
                    GestureDetector(
                        onTap: () {
                          addMessage();
                        },
                        child: Container(
                            height: 40,
                            width: 40,
                            decoration:
                                BoxDecoration(color: AppColor.iconLightGreen, borderRadius: BorderRadius.circular(40)),
                            child: Icon(
                              Icons.send_outlined,
                              color: AppColor.iconBlue,
                            ))),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool sendByMe;

  const MessageTile({super.key, required this.message, required this.sendByMe});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8, bottom: 8, left: sendByMe ? 0 : 24, right: sendByMe ? 24 : 0),
      alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: sendByMe ? const EdgeInsets.only(left: 30) : const EdgeInsets.only(right: 30),
        padding: const EdgeInsets.only(top: 20, bottom: 17, left: 20, right: 20),
        decoration: BoxDecoration(
            borderRadius: sendByMe
                ? const BorderRadius.only(
                    topLeft: Radius.circular(23), topRight: Radius.circular(23), bottomLeft: Radius.circular(23))
                : const BorderRadius.only(
                    topLeft: Radius.circular(23), topRight: Radius.circular(23), bottomRight: Radius.circular(23)),
            gradient: LinearGradient(
              colors: sendByMe
                  ? [AppColor.iconLightGreen, AppColor.iconLightGreen]
                  : [AppColor.iconBlue, AppColor.iconBlue],
            )),
        child: Text(message,
            textAlign: TextAlign.start,
            style: const TextStyle(
                color: Colors.white, fontSize: 16, fontFamily: 'OverpassRegular', fontWeight: FontWeight.w300)),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();
  bool _emojiShowing = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hamad",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.teal,
        leading:const Padding(
          padding:   EdgeInsets.only(left: 8,top: 4,bottom: 4),
          child: CircleAvatar(
            child: Center(child: Icon(Icons.person),),
          ),
        ),
        actions: const[
          Icon(Icons.call,color: Colors.white,),
          SizedBox(width: 15,),
          Icon(Icons.more_vert,color: Colors.white,),
          SizedBox(width: 10,)
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade100, Colors.teal.shade400],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  buildMessage(
                      isSentByMe: true,
                      message: "Hello! How are you?",
                      context: context),
                  buildMessage(
                      isSentByMe: false,
                      message: "I'm good, thanks! How about you?",
                      context: context),
                  buildMessage(
                      isSentByMe: true,
                      message: "I'm great! Just working on a project.",
                      context: context),
                ],
              ),
            ),
            buildMessageInput(),

            Offstage(
              offstage: !_emojiShowing,
              child: EmojiPicker(
                textEditingController: _controller,
                scrollController: _scrollController,
                config:const Config(
                  height: 286,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMessage({required bool isSentByMe, required String message, required BuildContext context}) {
    return Align(
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: isSentByMe ? Colors.teal.shade300 : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: isSentByMe ? const Radius.circular(20) : Radius.zero,
            bottomRight: isSentByMe ? Radius.zero : const Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Text(
          message,
          style: TextStyle(
            color: isSentByMe ? Colors.white : Colors.black87,
            fontSize: 16,
          ),
        ),
      ),
    );
  }




  Widget buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  )
                ],
              ),
              child:  TextField(
                onTap:(){
                  if(_emojiShowing==true){
                    setState(() {
                      _emojiShowing=false;
                    });
                  }

                },
                scrollController: _scrollController,
                controller: _controller,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: "Type a message",
                  border: InputBorder.none,
                  prefixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _emojiShowing = !_emojiShowing;
                        });
                        if (_emojiShowing) {
                          FocusScope.of(context).unfocus();
                        } else {
                          FocusScope.of(context).requestFocus();
                        }
                      },

                      child: Icon(_emojiShowing?Icons.keyboard:Icons.emoji_emotions_outlined)
                  ),
                  contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            decoration: const BoxDecoration(
              color: Colors.teal,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: () {
                // Handle sending message
              },
            ),
          ),
        ],
      ),
    );
  }
}
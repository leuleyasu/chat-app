import 'package:chat_app/Widget/chat_message.dart';
import 'package:chat_app/Widget/new_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
           FirebaseAuth.instance.signOut();
          }, icon: const  Icon(Icons.logout_outlined)),
        ],
      ),
      body: const Column(
        children: [
        Expanded(child: ChatMessages()),
        NewMessage()
        ],
      )
    );
  }
}
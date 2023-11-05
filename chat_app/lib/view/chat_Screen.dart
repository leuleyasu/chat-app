import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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
      body: Column(
        children: [
         Padding(
           padding: const EdgeInsets.all(50),
           child: Text("chat",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.amber),),
         )
        ],
      )
    );
  }
}
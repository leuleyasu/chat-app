import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  late final TextEditingController _messagecontroller;
  void _submitmessages() async {
    final entermessage = _messagecontroller.text;
    if (entermessage.trim().isEmpty) {
      return;
    }
    FocusScope.of(context).unfocus();
    _messagecontroller.clear();

    final user = FirebaseAuth.instance.currentUser!;
    final userData = await FirebaseFirestore.instance
        .collection("user_data_path")
        .doc(user.uid)
        .get();

    await FirebaseFirestore.instance.collection("ChatCollection").add({
      'text': entermessage,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
      ''
          'userName': userData.data()!['usernmae'],
      'userImage': userData.data()!['imageurl'],
    });


  }

  @override
  void initState() {
    _messagecontroller = TextEditingController();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _messagecontroller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 1, bottom: 14),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messagecontroller,
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              enableSuggestions: true,
              decoration: const InputDecoration(labelText: "Send a Message..."),
            ),
          ),
          IconButton(
              color: Theme.of(context).colorScheme.primary,
              onPressed: _submitmessages,
              icon: const Icon(Icons.send))
        ],
      ),
    );
  }
}

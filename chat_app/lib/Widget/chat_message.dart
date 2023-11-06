import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatefulWidget {
  const ChatMessages({super.key});

  @override
  State<ChatMessages> createState() => _ChatMessagesState();
}

class _ChatMessagesState extends State<ChatMessages> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("ChatCollection").snapshots(),
    builder: (context, snapshot) {
  switch (snapshot.connectionState) {
    case ConnectionState.waiting:
      return const Center(
        child: CircularProgressIndicator(),
      );
    case ConnectionState.done:
      if (snapshot.hasData) {
        final loadedMessages = snapshot.data!.docs;

        return ListView.builder(
          itemCount: loadedMessages.length,
          itemBuilder: (context, index) => Text(
            loadedMessages[index].data()!['text'],
          ),
        );
      }
      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
        return const Center(
          child: Text("No Message Found"),
        );
      }
      if (snapshot.hasError) {
        return const Center(
          child: Text("Something went wrong"),
        );
      }
      return const Center(
        child: Text("Unexpected State"),
      );

    default:
      return const Center(
        child: CircularProgressIndicator(),
      );
  }
},

    );
  }
}
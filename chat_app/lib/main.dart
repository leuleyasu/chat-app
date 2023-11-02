import 'package:chat_app/view/chat_Screen.dart';
import 'package:chat_app/view/splashscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'const/Routes.dart';
import 'view/Register.dart';
import 'view/login.dart';
import 'view/verifyemail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: StreamBuilder(
stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
if (snapshot.connectionState==ConnectionState.waiting) return const SplashScreen();
if (snapshot.hasData) return const ChatScreen();
return const Login();
        }

      ),
     routes: {
          loginRoute: (context) => const Login(),
          registerroute: (context) => const Register(),
          verifyemail: (context) => const VerifyEmail(),
          chatscreen:(context) => const ChatScreen(),
        });

  }
}

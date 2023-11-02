import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

import '../Service/auth/auth.exception.dart';
import '../Service/auth/auth_service.dart';
import '../Utilities/Show_Error_Dialog.dart';
import '../const/Routes.dart';
import '../firebase_options.dart';
class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});
  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  // TextEditingController emailverifycontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verfify Email Adress"),
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return Column(
                children: [
                  // TextField(
                  //   controller: emailverifycontroller,
                  // decoration: const InputDecoration(
                  //   hintText: "Email adress"
                  // ),

                  // ),
                  const Text(
                      "we've sent you an email verfication .please open and verify your account"),
                  const Text("if you haven't recieved press the button below"),
                  TextButton(
                      onPressed: () async {
                        await AuthService.firbase().sendEmailVerfication();
                      },
                      child: const Text("send email verfication")),

                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      TextButton(
                          onPressed: () async {
                            try {
                              await AuthService.firbase().logout();
                            } on UserNotFoundAuthException {
                              await showErrorDialog(context, "user not found");
                            } catch (e) {
                              devtools.log(e.toString());
                            }
                          },
                          child: const Text("Restart")),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(
                                context, loginRoute, (route) => false);
                          },
                          child: const Text("Login"))
                    ],
                  )
                ],
              );
            case ConnectionState.waiting:
              return const Text("Loading...");

            default:
              return const Text("Something went wrong...");
          }
        },
      ),
    );
  }
}

import 'package:chat_app/view/verifyemail.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developertool show log;
import '../Service/auth/auth.exception.dart';
import '../Service/auth/auth_service.dart';
import '../Utilities/Show_Error_Dialog.dart';
import '../const/Routes.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: FutureBuilder(
        future: AuthService.firbase().initializeApp(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return Center(
                child: Form(
                  child: Column(
                    children: [
                      TextField(
                        controller: _email,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(hintText: "Email"),
                      ),
                      TextField(
                        controller: _password,
                        autocorrect: false,
                        enableSuggestions: false,
                        obscureText: true,
                        decoration: const InputDecoration(hintText: "Password"),
                      ),
                      TextButton(
                        onPressed: () async {
                          try {
                            final email = _email.text;
                            final password = _password.text;
                            await AuthService.firbase()
                                .login(email: email, password: password);
                            final user = AuthService.firbase().currentUser;
                            if (user?.isEmailVerfied ??false) {
                              if (context.mounted) {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    chatscreen, (route) => false);
                              }else{
                                if (context.mounted) {
                               Navigator.of(context).pushNamedAndRemoveUntil(verifyemail, (route) => false);
                              }
                            }
                            }

                          } on UserNotFoundAuthException {
                            await showErrorDialog(context, 'user not found');
                          } on WrongPasswordAuthException {
                            await showErrorDialog(context, 'wrong password');
                          } on InvalidEmailException {
                            await showErrorDialog(context, 'invalid email');
                          } on GenericAuthException {
                            await showErrorDialog(context, 'Authentication Error');
                          } catch (e) {
                            await showErrorDialog(context, e.toString());
                            developertool.log(e.toString());

                            //  developertool.log(e.toString());
                          }
                        },
                        child: const Text("Login"),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(
                                context, registerroute, (route) => false);
                          },
                          child: const Text("Register Here"))
                    ],
                  ),
                ),
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

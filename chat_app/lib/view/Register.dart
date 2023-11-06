import 'dart:io';
import 'package:chat_app/Widget/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;
import '../Service/auth/auth.exception.dart';
import '../Service/auth/auth_service.dart';
import '../Utilities/Show_Error_Dialog.dart';
import '../const/Routes.dart';
import 'dart:developer' as developertool show log;

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _username;

  File? _selectedimage;
  bool isAuthenticaing = false;
  bool isVisiblePassword=false;
  void initState() {
    _username = TextEditingController();
    _password = TextEditingController();
    _email=TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
   _email.dispose();
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: FutureBuilder(
        future: AuthService.firbase().initializeApp(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return Column(
                children: [
                  Center(
                    child: Form(
                        child: Column(
                      children: [
                        PickImage(
                          onPickImage: (pickimagefile) =>
                              _selectedimage = pickimagefile,
                        ),
                         TextField(

                        controller: _username,
                        decoration: const InputDecoration(hintText: "Username"),
                      ),
                        TextField(
                          controller: _email,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(hintText: "Email"),
                        ),
                        InkWell(

                          child: TextField(
                            controller: _password,
                            autocorrect: false,
                            enableSuggestions: false,
                            obscureText: true,
                            decoration:
                                const InputDecoration(hintText: "Password"),
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            try {
                              setState(() {
                                isAuthenticaing = true;
                              });
                              final email = _email.text;
                              final password = _password.text;
                              final username=_username.text;
                              await AuthService.firbase().createuser(
                                email: email,
                                password: password,
                              );
                              final user = FirebaseAuth.instance.currentUser;

                              final imageRef =  FirebaseStorage.instance
                                  .ref()
                                  .child("user_image_folder")
                                  .child("${user!.uid}.jpg");
                              await imageRef.putFile(_selectedimage!);
                              final imageurl = await imageRef.getDownloadURL();

                              // developertool.log(imageurl);
                              FirebaseFirestore.instance.
                              collection("user_data_path")
                              .doc(user.uid).set({'username':username,
                              'email':email,'password':password,'imageurl':imageurl
                              });

                              setState(() {
                                isAuthenticaing = false;
                              });
                              // if (context.mounted) {
                              //   Navigator.of(context).pushNamed(verifyemail);
                              // }
                              AuthService.firbase().sendEmailVerfication();
                            } on WeakPasswordAuthException {
                              await showErrorDialog(context, 'weak password');
                            } on EmailAlreadyInUseExistAuthException {
                              await showErrorDialog(
                                  context, 'email already in-use');
                                   setState(() {
                                isAuthenticaing = false;
                              });
                            } on GenericAuthException {
                              await showErrorDialog(
                                  context, 'Failed to Register');
                              setState(() {
                                isAuthenticaing = false;
                              });
                            } catch (e) {
                              await showErrorDialog(context, e.toString());
                              devtools.log(e.toString());
                              setState(() {
                                isAuthenticaing = false;
                              });
                            }
                          },
                          child: isAuthenticaing
                              ? TextButton(
                                  onPressed: () {},
                                  child: const CircularProgressIndicator())
                              : const Text(
                                  "Register",
                                ),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, loginRoute, (route) => false);
                            },
                            child: const Text("Login Here"))
                      ],
                    )),
                  ),
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

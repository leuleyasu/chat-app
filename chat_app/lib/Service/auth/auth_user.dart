// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' show User;
@immutable
class AuthUser {

  final bool isEmailVerfied;

   const AuthUser({
 required  this.isEmailVerfied,

   }
  );

  factory AuthUser.fromFirebase(User user)=>AuthUser(isEmailVerfied: user.emailVerified );
}

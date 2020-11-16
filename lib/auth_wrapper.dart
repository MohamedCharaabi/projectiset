import 'package:auth/ui/views/homeProfessor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:auth/ui/views/register.dart';
import 'package:auth/ui/views/homeStudent.dart';
import 'package:auth/ui/views/login.dart';

class AuthWrapper extends StatefulWidget {
  final String pageType;

  AuthWrapper({this.pageType});

  @override
  _AuthWrapperState createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    // if (firebaseUser != null && getUserType(uid) == true) {
    //   print(firebaseUser);
    //   return HomeStudent();
    // } else if (firebaseUser != null && getUserType(uid) == false) {
    //   print(firebaseUser);
    //   return HomeProfessor();
    // } else if (pageType == 'login') {
    //   return LoginScreen();
    // } else if (pageType == 'register') {
    //   return RegisterScreen();
    // }
    // return SignedOutHomeScreen();

    return FutureBuilder(
      future: getUserType(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (firebaseUser != null && snapshot.data == true) {
            return HomeStudent();
          } else if (firebaseUser != null && snapshot.data == false) {
            print(firebaseUser);
            return HomeProfessor();
          } else if (widget.pageType == 'login') {
            return LoginScreen();
          } else if (widget.pageType == 'register') {
            return RegisterScreen();
          }
          return SignedOutHomeScreen();
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Future<bool> getUserType() async {
    String uid = FirebaseAuth.instance.currentUser.uid;
    final snapshot = await FirebaseFirestore.instance
        .collection("professors")
        .doc(uid)
        .get();

    //profesoor
    if (snapshot == null || !snapshot.exists) {
      return true;
    } else {
      //student
      return false;
    }
  }
}

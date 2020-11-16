import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:auth/services/auth.dart';

class HomeProfessor extends StatefulWidget {
  @override
  _HomeProfessorState createState() => _HomeProfessorState();
}

class _HomeProfessorState extends State<HomeProfessor> {
  String email = FirebaseAuth.instance.currentUser.email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Home Proff'),
            RaisedButton(
              onPressed: () {
                context.read<AuthService>().signOut();
              },
              child: Text('logout'),
            ),
            RaisedButton(
              onPressed: () {
                Fluttertoast.showToast(
                  msg: email,
                  toastLength: Toast.LENGTH_LONG,
                );
              },
              child: Text('Toast Eail'),
            ),
          ],
        ),
      ),
    );
  }
}

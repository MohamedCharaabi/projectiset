import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:auth/services/auth.dart';
import 'package:auth/auth_wrapper.dart';

class HomeStudent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String email = FirebaseAuth.instance.currentUser.email;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Home Student'),
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

class SignedOutHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AuthWrapper(pageType: 'login')),
                );
              },
              child: Text('login'),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AuthWrapper(pageType: 'register')),
                );
              },
              child: Text('register'),
            ),
          ],
        ),
      ),
    );
  }
}

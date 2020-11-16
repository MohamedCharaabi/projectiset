import 'package:auth/ui/views/register.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:auth/auth_wrapper.dart';
import 'package:auth/services/auth.dart';
import 'package:auth/validation/signup_validation.dart';

import 'package:provider/provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
            create: (_) => AuthService(FirebaseAuth.instance)),
        StreamProvider(
            create: (context) => context.read<AuthService>().authStateChanges),
        Provider<SignupValidation>(
          create: (_) => SignupValidation(),
        ),
        ChangeNotifierProvider(create: (BuildContext context) => IsStudent()),
      ],
      child: MaterialApp(
        home: AuthWrapper(),
      ),
    );
  }
}

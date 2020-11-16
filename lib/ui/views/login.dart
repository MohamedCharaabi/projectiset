import 'package:flutter/material.dart';
import 'package:auth/validation/signup_validation.dart';
import 'package:provider/provider.dart';
import 'package:auth/services/auth.dart';
import 'package:auth/ui/components/exit_button.dart';
import 'package:auth/ui/components/form_field.dart';
import 'package:auth/ui/components/login_options.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 15.0),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExitButton(),
            Text(
              'Welcome\nBack',
              style: TextStyle(
                color: Colors.grey[800],
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            Column(
              children: [
                FormTextField(
                  fieldType: 'email',
                  controller: _emailController,
                ),
                FormTextField(
                  fieldType: 'password',
                  controller: _passwordController,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 7.0),
                  child: Text('Sign in',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 19.0,
                      )),
                ),
                RaisedButton(
                  padding: EdgeInsets.all(15.0),
                  onPressed: () {
                    context
                        .read<SignupValidation>()
                        .validateEmail(_emailController.text.trim());

                    if (context.read<SignupValidation>().isValid == true) {
                      context.read<AuthService>().signIn(
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                          );
                    }
                  },
                  shape: CircleBorder(),
                  color: Colors.orange[800],
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ],
            ),
            LoginOptions(),
            OtherOptions(pageType: 'login')
          ],
        ),
      ),
    );
  }
}

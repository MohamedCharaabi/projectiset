import 'package:flutter/material.dart';
import 'package:auth/auth_wrapper.dart';
import 'package:sign_button/sign_button.dart';

class LoginOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SignInButton.mini(
          elevation: 1,
          padding: 10,
          btnColor: Colors.white,
          buttonType: ButtonType.google,
          onPressed: () {},
        ),
        SignInButton.mini(
          elevation: 1,
          padding: 10,
          btnColor: Colors.white,
          buttonType: ButtonType.apple,
          onPressed: () {},
        ),
        SignInButton.mini(
          elevation: 1,
          padding: 10,
          btnColor: Colors.white,
          buttonType: ButtonType.facebook,
          onPressed: () {},
        )
      ],
    );
  }
}

class OtherOptions extends StatelessWidget {
  final String pageType;

  OtherOptions({this.pageType});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AuthWrapper(
                    pageType: pageType == 'login' ? 'register' : 'login'),
              ),
            ),
            child: Text(pageType == 'login' ? 'Sign up' : 'Sign in',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13.0,
                    decoration: TextDecoration.underline,
                    decorationThickness: 1.5)),
          ),
          pageType == 'login'
              ? InkWell(
                  child: Text('Forget password?',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 13.0,
                          decoration: TextDecoration.underline,
                          decorationThickness: 1.5)),
                )
              : Container(),
        ],
      ),
    );
  }
}

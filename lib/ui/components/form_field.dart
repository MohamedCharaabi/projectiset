import 'package:flutter/material.dart';
import 'package:auth/validation/signup_validation.dart';
import 'package:provider/provider.dart';

class FormTextField extends StatelessWidget {
  final String fieldType;
  final TextEditingController controller;

  FormTextField({this.controller, this.fieldType});

  @override
  Widget build(BuildContext context) {
    final validationService = context.watch<SignupValidation>();

    String errorMessagePicker() {
      if (fieldType == 'password') {
        return validationService.password.error;
      } else if (fieldType == 'email') {
        return validationService.email.error;
      } else {
        return validationService.username.error;
      }
    }

    String hintTextPicker() {
      if (fieldType == 'password') {
        return 'Password';
      } else if (fieldType == 'email') {
        return 'Email address';
      } else if (fieldType == 'username') {
        return 'Username';
      } else {
        return '$fieldType';
      }
    }

    return TextField(
      controller: controller,
      obscureText: fieldType == 'password' ? true : false,
      decoration: InputDecoration(
        errorText: errorMessagePicker(),
        contentPadding: EdgeInsets.only(
          top: 10.0,
          left: 5.0,
        ),
        hintText: hintTextPicker(),
        hintStyle: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.w500,
          fontSize: 14.0,
        ),
      ),
    );
  }
}

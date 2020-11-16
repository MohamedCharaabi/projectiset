import 'package:flutter/material.dart';
import 'package:auth/validation/signup_validation.dart';
import 'package:provider/provider.dart';
import 'package:auth/services/auth.dart';
import 'package:auth/ui/components/exit_button.dart';
import 'package:auth/ui/components/form_field.dart';
import 'package:auth/ui/components/login_options.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool student;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return IsStudent();
      },
      child: Scaffold(
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
                'Sign up and\nstart learning',
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Column(
                children: [
                  Container(
                    height: 44,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(33),
                      color: Colors.grey,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Consumer<IsStudent>(
                            builder: (context, isStudent, child) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isStudent.setIsStudent(false);
                                    student = false;
                                  });
                                },
                                child: Container(
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    color: isStudent.isStudent
                                        ? Colors.grey
                                        : Colors.orange,
                                    borderRadius: BorderRadius.circular(33),
                                  ),
                                  child: Center(child: Text('Proffessor')),
                                ),
                              );
                            },
                          ),
                        ),
                        Expanded(
                          child: Consumer<IsStudent>(
                            builder: (context, isStudent, child) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isStudent.setIsStudent(true);
                                    student = true;
                                  });
                                },
                                child: Container(
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    color: isStudent.isStudent
                                        ? Colors.orange
                                        : Colors.grey,
                                    borderRadius: BorderRadius.circular(33),
                                  ),
                                  child: Center(child: Text('Student')),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  FormTextField(
                    fieldType: 'username',
                    controller: _usernameController,
                  ),
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
                    child: Text('Sign up',
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
                      context
                          .read<SignupValidation>()
                          .validatePassword(_passwordController.text.trim());
                      context
                          .read<SignupValidation>()
                          .validateUsername(_usernameController.text.trim());

                      if (context.read<SignupValidation>().isValid == true) {
                        context.read<AuthService>().signUp(
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                            isStudent: student,
                            username: _usernameController.text.trim());
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
              OtherOptions(pageType: 'register')
            ],
          ),
        ),
      ),
    );
  }
}

class IsStudent extends ChangeNotifier {
  bool isStudent = false;

  bool getType() {
    return isStudent;
  }

  setIsStudent(bool value) {
    isStudent = value;
    notifyListeners();
  }
}

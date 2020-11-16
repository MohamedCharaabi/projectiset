import 'package:flutter/material.dart';
import 'package:auth/ui/views/homeStudent.dart';

class ExitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SignedOutHomeScreen(),
          )),
      child: Container(
        padding: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          border: Border.all(width: 0, color: Colors.transparent),
          borderRadius: BorderRadius.all(Radius.circular(50.0)),
        ),
        child: Icon(
          Icons.close_rounded,
          size: 18,
          color: Colors.grey[850],
        ),
      ),
    );
  }
}

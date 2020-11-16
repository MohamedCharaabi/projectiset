import 'package:auth/validation/validation_item.dart';
import 'package:email_validator/email_validator.dart';

class SignupValidation {
  ValidationItem _username = ValidationItem(null, null);
  ValidationItem _email = ValidationItem(null, null);
  ValidationItem _password = ValidationItem(null, null);

  ValidationItem get username => _username;
  ValidationItem get email => _email;
  ValidationItem get password => _password;
  bool get isValid {
    if (_username.error == null &&
        _email.error == null &&
        _password.error == null) {
      return true;
    } else {
      return false;
    }
  }

  void validateUsername(String value) {
    if (value.length >= 3) {
      _username = ValidationItem(value, null);
    } else {
      _username = ValidationItem(null, 'Must be at least 3 characters');
    }
  }

  void validateEmail(String value) {
    var valid = EmailValidator.validate(value);

    if (valid == true) {
      _email = ValidationItem(value, null);
    } else {
      _email = ValidationItem(null, 'Email is not valid');
    }
  }

  void validatePassword(String value) {
    if (value.length >= 6) {
      _password = ValidationItem(value, null);
    } else {
      _password = ValidationItem(null, 'Must be at least 6 characters');
    }
  }
}

import 'package:flutter/material.dart';

abstract class EmailValidation {}

class EmailPassed extends EmailValidation {}

class EmailEmpty extends EmailValidation {}

class EmailNotValid extends EmailValidation {}

EmailValidation validateEmail(String? email, {bool isRequired = true}) {
  if (email == null || email.isEmpty) {
    if (isRequired) {
      return EmailEmpty();
    }
  }

  var isValidEmail = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email ?? "");

  if (email != null && email.isNotEmpty) {
    if (!isValidEmail) {
      return EmailNotValid();
    }
  }

  return EmailPassed();
}

String? validateEmailWithReturnErrorMessage(
    String InterEmail, BuildContext context) {
  var email = validateEmail(InterEmail);
  String? message;
  if (email is EmailNotValid) {
    message = 'Pleas Inter valid Email';
  }
  if (email is EmailEmpty) {
    message = 'Please Input Email';
  }

  return message;
}

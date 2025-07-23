import 'package:flutter/material.dart';

abstract class PasswordValidation {}

class PasswordPassed extends PasswordValidation {}

class PasswordEmpty extends PasswordValidation {}

class PasswordLengthNotValid extends PasswordValidation {}

class PasswordNotComplex extends PasswordValidation {}

PasswordValidation validatePassword(String? password) {
  if (password == null || password.isEmpty) {
    return PasswordEmpty();
  }

  if (password.length < 8 || password.length > 84) {
    return PasswordLengthNotValid();
  }

  if (!password.contains(RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$'))) {
    return PasswordNotComplex();
  }

  return PasswordPassed();
}

String? validatePasswordWithReturnErrorMessage(
    String InterEmail, BuildContext context) {
  var email = validatePassword(InterEmail);
  String? message;
  if (email is PasswordEmpty) {
    message = 'Pleas Inter Password';
  }
  if (email is PasswordLengthNotValid) {
    message = 'Please Input Length Valid';
  }
  if (email is PasswordNotComplex) {
    message = 'Please Input Complex Password';
  }

  return message;
}

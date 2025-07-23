import 'package:flutter/material.dart';

abstract class NameValidation {}

class NamePassed extends NameValidation {}

class NameEmpty extends NameValidation {}

class NameLengthNotValid extends NameValidation {}

NameValidation validateName(String? name, {bool isRequired = true}) {
  if (name == null || name.isEmpty) {
    if (isRequired) {
      return NameEmpty();
    }
  }

  if (name != null && name.isNotEmpty) {
    if (name.length < 3 || name.length > 25) {
      return NameLengthNotValid();
    }
  }

  return NamePassed();
}

String? validateNameWithReturnErrorMessage(
    String interName, BuildContext context) {
  var name = validateName(interName);
  String? message;
  if (name is NameEmpty) {
    message = 'Pleas Inter your Name';
  }
  if (name is NameLengthNotValid) {
    message = 'Name Length Not Valid';
  }

  return message;
}

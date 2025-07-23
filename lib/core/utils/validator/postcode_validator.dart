import 'package:flutter/material.dart';

abstract class PostCodeValidation {}

class PostCodePassed extends PostCodeValidation {}

class PostCodeEmpty extends PostCodeValidation {}

class PostCodeLengthNotValid extends PostCodeValidation {}

PostCodeValidation validatePostCode(String? name, {bool isRequired = true}) {
  if (name == null || name.isEmpty) {
    if (isRequired) {
      return PostCodeEmpty();
    }
  }

  return PostCodePassed();
}

String? validatePostCodeWithReturnErrorMessage(
    String interName, BuildContext context) {
  var name = validatePostCode(interName);
  String? message;
  if (name is PostCodeEmpty) {
    message = 'Pleas Inter PostCode';
  }

  return message;
}

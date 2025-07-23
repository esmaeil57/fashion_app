import 'package:flutter/material.dart';

abstract class DropDownValidation implements Exception {}

class DropDownPassed extends DropDownValidation {}

class DropDownEmpty extends DropDownValidation {}

DropDownValidation validateDropDownState(String? value) {
  debugPrint("valuesssss is...... ${value}");
  if (value == null || value.isEmpty) {
    debugPrint("valuesssss is inside if ...... ${value}");

    return DropDownEmpty();
  }

  return DropDownPassed();
}

String? validateDropDown(
    String? value, String fieldName, BuildContext context) {
  var validateDropDown = validateDropDownState(value);
  String? message;

  // Returns locale string in the form 'en_US'
  if (validateDropDown is DropDownEmpty) {
    // if (appLocale.languageCode == "ar") {
    //   message =
    //       "${AppStrings.lblFieldEmptyError.tr()} $fieldName";
    // } else {
    message = "$fieldName is required ";
    // }
  }

  return message;
}

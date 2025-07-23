import 'package:flutter/material.dart';

abstract class AddressValidation {}

class NamePassed extends AddressValidation {}

class NameEmpty extends AddressValidation {}

class NameLengthNotValid extends AddressValidation {}

AddressValidation validateAddress(String? name, {bool isRequired = true}) {
  if (name == null || name.isEmpty) {
    if (isRequired) {
      return NameEmpty();
    }
  }

  return NamePassed();
}

String? validateAddressWithReturnErrorMessage(
    String interName, BuildContext context) {
  var name = validateAddress(interName);
  String? message;
  if (name is NameEmpty) {
    message = 'Pleas Inter your Address';
  }

  return message;
}

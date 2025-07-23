import 'package:flutter/material.dart';

abstract class PhoneValidation implements Exception {}

class PhonePassed extends PhoneValidation {}

class PhoneEmpty extends PhoneValidation {}

class PhoneNotEgypt extends PhoneValidation {}

class PhoneLengthNotValid extends PhoneValidation {}

PhoneValidation validatePhone(String? phone) {
  if (phone == null || phone.isEmpty) {
    return PhoneEmpty();
  }

  if (phone.length < 12 || phone.length > 12) {
    return PhoneLengthNotValid();
  }

  if (!phone.startsWith("002")) {
    return PhoneNotEgypt();
  }

  return PhonePassed();
}

String? validatePhoneNumberWithReturnErrorMessage(
    String interPhoneNumber, BuildContext context) {
  var phoneNumber = validatePhone(interPhoneNumber);
  String? message;
  if (phoneNumber is PhoneEmpty) {
    message = 'Pleas Inter your Phone Number';
  }
  if (phoneNumber is PhoneNotEgypt) {
    message = 'Phone Not Egypt';
  }
  if (phoneNumber is PhoneLengthNotValid) {
    message = 'Phone Length Not Valid';
  }

  return message;
}

class User {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String phoneNumber;
  final String language;
  final bool emailPermission;
  final bool smsPermission;
  final bool acceptedTerms;

  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.language,
    required this.emailPermission,
    required this.smsPermission,
    required this.acceptedTerms,
  });

  User copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? phoneNumber,
    String? language,
    bool? emailPermission,
    bool? smsPermission,
    bool? acceptedTerms,
  }) {
    return User(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      language: language ?? this.language,
      emailPermission: emailPermission ?? this.emailPermission,
      smsPermission: smsPermission ?? this.smsPermission,
      acceptedTerms: acceptedTerms ?? this.acceptedTerms,
    );
  }
}
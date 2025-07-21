import '../../domain/entities/user.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoginMode extends ProfileState {
  final String email;
  final String password;
  final bool isPasswordVisible;

  ProfileLoginMode({
    this.email = '',
    this.password = '',
    this.isPasswordVisible = false,
  });
}

class ProfileSignUpMode extends ProfileState {
  final User user;
  final bool isPasswordVisible;

  ProfileSignUpMode({
    required this.user,
    this.isPasswordVisible = false,
  });
}

class ProfileSuccess extends ProfileState {}

class ProfileError extends ProfileState {
  final String message;
  
  ProfileError(this.message);
}
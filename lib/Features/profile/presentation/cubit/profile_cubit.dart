import 'package:fashion/Features/profile/presentation/cubit/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/user.dart';
import '../../domain/usecase/user_usecase.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final TrackOrderUseCase trackOrderUseCase;

  ProfileCubit({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.trackOrderUseCase,
  }) : super(ProfileInitial());

  void switchToLogin() {
    emit(ProfileLoginMode());
  }

  void switchToSignUp() {
    emit(ProfileSignUpMode(
      user: User(
        firstName: '',
        lastName: '',
        email: '',
        password: '',
        phoneNumber: '',
        language: 'English',
        emailPermission: false,
        smsPermission: false,
        acceptedTerms: false,
      ),
    ));
  }

  void updateLoginEmail(String email) {
    if (state is ProfileLoginMode) {
      final currentState = state as ProfileLoginMode;
      emit(ProfileLoginMode(
        email: email,
        password: currentState.password,
        isPasswordVisible: currentState.isPasswordVisible,
      ));
    }
  }

  void updateLoginPassword(String password) {
    if (state is ProfileLoginMode) {
      final currentState = state as ProfileLoginMode;
      emit(ProfileLoginMode(
        email: currentState.email,
        password: password,
        isPasswordVisible: currentState.isPasswordVisible,
      ));
    }
  }

  void toggleLoginPasswordVisibility() {
    if (state is ProfileLoginMode) {
      final currentState = state as ProfileLoginMode;
      emit(ProfileLoginMode(
        email: currentState.email,
        password: currentState.password,
        isPasswordVisible: !currentState.isPasswordVisible,
      ));
    }
  }

  void updateSignUpUser(User user) {
    if (state is ProfileSignUpMode) {
      final currentState = state as ProfileSignUpMode;
      emit(ProfileSignUpMode(
        user: user,
        isPasswordVisible: currentState.isPasswordVisible,
      ));
    }
  }

  void toggleSignUpPasswordVisibility() {
    if (state is ProfileSignUpMode) {
      final currentState = state as ProfileSignUpMode;
      emit(ProfileSignUpMode(
        user: currentState.user,
        isPasswordVisible: !currentState.isPasswordVisible,
      ));
    }
  }

  Future<void> login() async {
    if (state is! ProfileLoginMode) return;
    
    final currentState = state as ProfileLoginMode;
    emit(ProfileLoading());
    
    try {
      await loginUseCase.execute(currentState.email, currentState.password);
      emit(ProfileSuccess());
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> register() async {
    if (state is! ProfileSignUpMode) return;
    
    final currentState = state as ProfileSignUpMode;
    emit(ProfileLoading());
    
    try {
      await registerUseCase.execute(currentState.user);
      emit(ProfileSuccess());
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> trackOrder(String orderId) async {
    emit(ProfileLoading());
    
    try {
      await trackOrderUseCase.execute(orderId);
      emit(ProfileSuccess());
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}

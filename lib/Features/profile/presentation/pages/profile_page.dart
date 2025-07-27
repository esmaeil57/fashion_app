import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/usecase/user_usecase.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';
import '../widgets/profile_header.dart';
import '../widgets/login_form.dart';
import '../widgets/signup_form.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  
  @override
  State<StatefulWidget> createState() {
    return _ProfilePageState();
      }

  
}

class _ProfilePageState extends State<ProfilePage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(
        loginUseCase: LoginUseCase(AuthRepositoryImpl()),
        registerUseCase: RegisterUseCase(AuthRepositoryImpl()),
        trackOrderUseCase: TrackOrderUseCase(AuthRepositoryImpl()),
      )..switchToLogin(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              const ProfileHeader(),
              Expanded(
                child: SingleChildScrollView(
                  child: BlocBuilder<ProfileCubit, ProfileState>(
                    builder: (context, state) {
                      if (state is ProfileLoading) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(50),
                            child: CircularProgressIndicator(
                              color: Color(0xFFD32F2F),
                            ),
                          ),
                        );
                      }
                      
                      if (state is ProfileLoginMode) {
                        return LoginForm(
                          emailController: _emailController,
                          passwordController: _passwordController,
                          state: state,
                        );
                      } else if (state is ProfileSignUpMode) {
                        return SignUpForm(
                          emailController: _emailController,
                          passwordController: _passwordController,
                          firstNameController: _firstNameController,
                          lastNameController: _lastNameController,
                          phoneController: _phoneController,
                          state: state,
                        );
                      }
                      
                      return LoginForm(
                        emailController: _emailController,
                        passwordController: _passwordController,
                        state: ProfileLoginMode(),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}
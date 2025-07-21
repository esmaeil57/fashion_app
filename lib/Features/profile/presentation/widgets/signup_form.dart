import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';
import '../widgets/logo_widget.dart';
import '../widgets/tab_bar_widget.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_buttons.dart';
import '../widgets/menu_section.dart';
import '../widgets/language_section.dart';
import '../widgets/permissions_section.dart';
import '../widgets/terms_checkbox.dart';

class SignUpForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController phoneController;
  final ProfileSignUpMode state;

  const SignUpForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.firstNameController,
    required this.lastNameController,
    required this.phoneController,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const LogoWidget(),
          const SizedBox(height: 30),
          const CustomTabBar(isLogin: false),
          const SizedBox(height: 30),
          CustomTextField(
            hint: 'First Name',
            controller: firstNameController,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            hint: 'Last Name',
            controller: lastNameController,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            hint: 'Your E-Mail Address',
            controller: emailController,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            hint: 'Your Password',
            controller: passwordController,
            obscure: !state.isPasswordVisible,
            suffixIcon: IconButton(
              icon: Icon(
                state.isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey,
              ),
              onPressed: () => context.read<ProfileCubit>().toggleSignUpPasswordVisibility(),
            ),
          ),
          const SizedBox(height: 16),
          CustomTextField(
            hint: '+20 _ _ _ _ _ _',
            controller: phoneController,
          ),
          const SizedBox(height: 20),
          LanguageSection(state: state),
          const SizedBox(height: 20),
          PermissionsSection(state: state),
          const SizedBox(height: 20),
          TermsCheckbox(state: state),
          const SizedBox(height: 30),
          RedButton(
            text: 'CREATE AN ACCOUNT',
            onPressed: () => context.read<ProfileCubit>().register(),
          ),
          const SizedBox(height: 20),
          Text(
            'or if you have an account',
            style: TextStyle(color: Colors.grey[800]),
          ),
          const SizedBox(height: 16),
          WhiteButton(
            text: 'LOGIN',
            onPressed: () => context.read<ProfileCubit>().switchToLogin(),
          ),
          const SizedBox(height: 40),
          const MenuSection(),
        ],
      ),
    );
  }
}
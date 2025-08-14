import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';
import '../widgets/logo_widget.dart';
import '../widgets/tab_bar_widget.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_buttons.dart';
import '../widgets/menu_section.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final ProfileLoginMode state;

  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
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
          const CustomTabBar(isLogin: true),
          const SizedBox(height: 30),
          CustomTextField(
            hint: 'your_email_address'.tr(),
            controller: emailController,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            hint: 'your_password'.tr(),
            controller: passwordController,
            obscure: !state.isPasswordVisible,
            suffixIcon: IconButton(
              icon: Icon(
                state.isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey,
              ),
              onPressed: () => context.read<ProfileCubit>().toggleLoginPasswordVisibility(),
            ),
          ),
          const SizedBox(height: 30),
          RedButton(
            text: 'login'.tr().toUpperCase(),
            onPressed: () => context.read<ProfileCubit>().login(),
          ),
          const SizedBox(height: 20),
          Text(
            'or_if_you_dont_have_account'.tr(),
            style: TextStyle(color: Colors.grey[600]),
          ),
          const SizedBox(height: 16),
          WhiteButton(
            text: 'create_an_account'.tr().toUpperCase(),
            onPressed: () => context.read<ProfileCubit>().switchToSignUp(),
          ),
          const SizedBox(height: 40),
          const MenuSection(),
        ],
      ),
    );
  }
}
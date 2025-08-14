import 'package:easy_localization/easy_localization.dart';
import 'package:fashion/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:fashion/features/profile/presentation/cubit/profile_state.dart';
import 'package:fashion/features/profile/presentation/widgets/custom_buttons.dart';
import 'package:fashion/features/profile/presentation/widgets/custom_text_field.dart';
import 'package:fashion/features/profile/presentation/widgets/language_section.dart';
import 'package:fashion/features/profile/presentation/widgets/logo_widget.dart';
import 'package:fashion/features/profile/presentation/widgets/menu_section.dart';
import 'package:fashion/features/profile/presentation/widgets/permissions_section.dart';
import 'package:fashion/features/profile/presentation/widgets/tab_bar_widget.dart';
import 'package:fashion/features/profile/presentation/widgets/terms_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            hint: 'first_name'.tr(),
            controller: firstNameController,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            hint: 'last_name'.tr(),
            controller: lastNameController,
          ),
          const SizedBox(height: 16),
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
              onPressed: () => context.read<ProfileCubit>().toggleSignUpPasswordVisibility(),
            ),
          ),
          const SizedBox(height: 16),
          CustomTextField(
            hint: 'phone_placeholder'.tr(),
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
            text: 'create_an_account'.tr().toUpperCase(),
            onPressed: () => context.read<ProfileCubit>().register(),
          ),
          const SizedBox(height: 20),
          Text(
            'or_if_you_have_account'.tr(),
            style: TextStyle(color: Colors.grey[800]),
          ),
          const SizedBox(height: 16),
          WhiteButton(
            text: 'login'.tr().toUpperCase(),
            onPressed: () => context.read<ProfileCubit>().switchToLogin(),
          ),
          const SizedBox(height: 40),
          const MenuSection(),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';

class TermsCheckbox extends StatelessWidget {
  final ProfileSignUpMode state;

  const TermsCheckbox({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
          value: state.user.acceptedTerms,
          onChanged: (value) {
            context.read<ProfileCubit>().updateSignUpUser(
              state.user.copyWith(acceptedTerms: value),
            );
          },
          activeColor: const Color(0xFFD32F2F),
        ),
        Expanded(
          child: RichText(
            text: const TextSpan(
              style: TextStyle(color: Colors.black, fontSize: 14),
              children: [
                TextSpan(text: 'I have read and accepted '),
                TextSpan(
                  text: 'Privacy Policy',
                  style: TextStyle(
                    color: Color(0xFFD32F2F),
                    decoration: TextDecoration.underline,
                  ),
                ),
                TextSpan(text: ' and '),
                TextSpan(
                  text: 'Terms and Conditions',
                  style: TextStyle(
                    color: Color(0xFFD32F2F),
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
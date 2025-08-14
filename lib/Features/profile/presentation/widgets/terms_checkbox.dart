import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
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
            text: TextSpan(
              style: const TextStyle(color: Colors.black, fontSize: 14),
              children: [
                TextSpan(text: 'terms_acceptance'.tr()),
                TextSpan(
                  text: 'privacy_policy'.tr(),
                  style: const TextStyle(
                    color: Color(0xFFD32F2F),
                    decoration: TextDecoration.underline,
                  ),
                ),
                TextSpan(text: 'and'.tr()),
                TextSpan(
                  text: 'terms_conditions'.tr(),
                  style: const TextStyle(
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
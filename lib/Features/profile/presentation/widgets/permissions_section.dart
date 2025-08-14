import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';

class PermissionsSection extends StatelessWidget {
  final ProfileSignUpMode state;

  const PermissionsSection({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'permission_question'.tr(),
          style: const TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Checkbox(
                    value: state.user.emailPermission,
                    onChanged: (value) {
                      context.read<ProfileCubit>().updateSignUpUser(
                        state.user.copyWith(emailPermission: value),
                      );
                    },
                    activeColor: const Color(0xFFD32F2F),
                  ),
                  Text('email'.tr()),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Checkbox(
                    value: state.user.smsPermission,
                    onChanged: (value) {
                      context.read<ProfileCubit>().updateSignUpUser(
                        state.user.copyWith(smsPermission: value),
                      );
                    },
                    activeColor: const Color(0xFFD32F2F),
                  ),
                  Text('sms'.tr()),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
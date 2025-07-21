import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        const Text(
          'Would you like to give us permission to contact you using one or more of the methods below?',
          style: TextStyle(fontSize: 14),
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
                  const Text('E-mail'),
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
                  const Text('SMS'),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
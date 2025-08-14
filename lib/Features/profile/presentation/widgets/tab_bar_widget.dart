import 'package:easy_localization/easy_localization.dart';
import 'package:fashion/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomTabBar extends StatelessWidget {
  final bool isLogin;

  const CustomTabBar({
    super.key,
    required this.isLogin,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => context.read<ProfileCubit>().switchToLogin(),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: isLogin ? const Color(0xFFD32F2F) : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
              child: Text(
                'login'.tr().toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isLogin ? const Color(0xFFD32F2F) : Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () => context.read<ProfileCubit>().switchToSignUp(),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: !isLogin ? const Color(0xFFD32F2F) : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
              child: Text(
                'sign_up'.tr().toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: !isLogin ? const Color(0xFFD32F2F) : Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
import 'package:fallnews/core/constant/app_dimens.dart';
import 'package:fallnews/presentation/features/auth/bloc/password_visivility/password_visibility_bloc.dart';
import 'package:fallnews/presentation/features/auth/bloc/password_visivility/password_visibility_event.dart';
import 'package:fallnews/presentation/features/auth/bloc/password_visivility/password_visibility_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommonTextFormField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isPassword;
  final TextInputType keyboardType;

  const CommonTextFormField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    if (isPassword) {
      return BlocBuilder<PasswordVisibilityBloc, PasswordVisibilityState>(
        builder: (context, state) {
          return TextFormField(
            controller: controller,
            obscureText: state.isHidden,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: hintText,
              contentPadding: EdgeInsets.symmetric(
                horizontal: AppDimens.w16,
                vertical: AppDimens.h14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDimens.r12),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  state.isHidden ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  context.read<PasswordVisibilityBloc>().add(
                    TogglePasswordVisibilityEvent(),
                  );
                },
              ),
            ),
          );
        },
      );
    } else {
      return TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: EdgeInsets.symmetric(
            horizontal: AppDimens.w16,
            vertical: AppDimens.h14,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimens.r12),
          ),
        ),
      );
    }
  }
}

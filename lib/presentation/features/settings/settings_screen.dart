import 'package:fallnews/core/constant/app_colors.dart';
import 'package:fallnews/core/constant/app_dimens.dart';
import 'package:fallnews/core/constant/app_strings.dart';
import 'package:fallnews/presentation/features/auth/bloc/auth/auth_bloc.dart';
import 'package:fallnews/presentation/features/auth/bloc/auth/auth_event.dart';
import 'package:fallnews/presentation/features/auth/bloc/auth/auth_state.dart';
import 'package:fallnews/presentation/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:fallnews/core/routes/app_routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        User? user = FirebaseAuth.instance.currentUser;

        return Scaffold(
          appBar: AppBar(
            title: Text('Settings', style: textTheme.headlineMedium),
          ),
          body: Padding(
            padding: EdgeInsets.all(AppDimens.r16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppDimens.h16,
              children: [
                Text('Account Details', style: textTheme.headlineSmall),
                if (user != null) ...[
                  _buildProfileDetailField(
                    'Name',
                    user.displayName ?? 'No Name',
                    textTheme,
                  ),
                  _buildProfileDetailField(
                    'Email',
                    user.email ?? 'No Email',
                    textTheme,
                  ),
                ] else ...[
                  const Center(child: Text('No user logged in')),
                ],
                SizedBox(height: AppDimens.h24),
                _buildLogoutButton(context, user != null),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProfileDetailField(
    String label,
    String value,
    TextTheme textTheme,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(value, style: textTheme.bodyMedium),
      ],
    );
  }

  Widget _buildLogoutButton(BuildContext context, bool isLoggedIn) {
    return PrimaryButton(
      buttonText: AppStrings.logout,
      onPressed: () {
        if (isLoggedIn) {
          context.read<AuthBloc>().add(LogoutUser());
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.login,
            (route) => false,
          );
        }
      },
      buttonColor: AppColors.error,
    );
  }
}

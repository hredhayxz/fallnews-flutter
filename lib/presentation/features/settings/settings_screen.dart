import 'package:fallnews/core/constant/app_colors.dart';
import 'package:fallnews/core/constant/app_dimens.dart';
import 'package:fallnews/core/constant/app_strings.dart';
import 'package:fallnews/presentation/features/auth/bloc/auth/auth_bloc.dart';
import 'package:fallnews/presentation/features/auth/bloc/auth/auth_event.dart';
import 'package:fallnews/presentation/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:fallnews/core/routes/app_routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  final String userName = "John Doe";
  final String userEmail = "johndoe@example.com";

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text('Settings', style: textTheme.headlineMedium)),
      body: Padding(
        padding: EdgeInsets.all(AppDimens.r16),
        child: Column(
          spacing: AppDimens.h16,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Account Details', style: textTheme.headlineSmall),
            _buildProfileDetailField('Name', userName, textTheme),
            _buildProfileDetailField('Email', userEmail, textTheme),
            SizedBox(height: AppDimens.h8),
            _buildLogoutButton(context),
          ],
        ),
      ),
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

  // Log Out button
  Widget _buildLogoutButton(BuildContext context) {
    return PrimaryButton(
      buttonText: AppStrings.logout,
      onPressed: () {
        context.read<AuthBloc>().add(LogoutUser());
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.login,
          (route) => false,
        );
      },
      buttonColor: AppColors.error,
    );
  }
}

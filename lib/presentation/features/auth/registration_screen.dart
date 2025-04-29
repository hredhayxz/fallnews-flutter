import 'package:fallnews/core/constant/app_colors.dart';
import 'package:fallnews/core/constant/app_dimens.dart';
import 'package:fallnews/presentation/features/auth/bloc/auth/auth_bloc.dart';
import 'package:fallnews/presentation/features/auth/bloc/auth/auth_event.dart';
import 'package:fallnews/presentation/features/auth/bloc/auth/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fallnews/core/routes/app_routes.dart';
import 'package:fallnews/presentation/widgets/common_text_form_field.dart';
import 'package:fallnews/presentation/widgets/primary_button.dart';

class RegistrationScreen extends StatelessWidget {
  RegistrationScreen({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text('Sign Up', style: textTheme.headlineMedium)),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppDimens.r16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Create an Account', style: textTheme.displaySmall),
            SizedBox(height: AppDimens.h8),
            Text('Sign up to get started', style: textTheme.bodyMedium),
            SizedBox(height: AppDimens.h24),
            CommonTextFormField(hintText: 'Name', controller: nameController),
            SizedBox(height: AppDimens.h16),
            CommonTextFormField(
              hintText: 'Email',
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: AppDimens.h16),
            CommonTextFormField(
              hintText: 'Password',
              controller: passwordController,
              isPassword: true,
            ),
            SizedBox(height: AppDimens.h16),
            CommonTextFormField(
              hintText: 'Confirm Password',
              controller: confirmPasswordController,
              isPassword: true,
            ),
            SizedBox(height: AppDimens.h24),
            BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Registration Successful')),
                  );
                  Navigator.pushReplacementNamed(context, AppRoutes.newsHome);
                } else if (state is AuthFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Registration Failed: ${state.error}'),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is AuthLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                return PrimaryButton(
                  buttonText: 'Sign Up',
                  onPressed: () {
                    if (passwordController.text !=
                        confirmPasswordController.text) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Passwords do not match')),
                      );
                      return;
                    }
                    context.read<AuthBloc>().add(
                      RegisterUser(
                        name: nameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                      ),
                    );
                  },
                );
              },
            ),
            SizedBox(height: AppDimens.h16),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.login);
                },
                child: Text(
                  'Already have an account? Sign In',
                  style: textTheme.titleMedium?.copyWith(color: AppColors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

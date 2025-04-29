import 'package:fallnews/core/constant/app_colors.dart';
import 'package:fallnews/core/constant/app_dimens.dart';
import 'package:fallnews/core/routes/app_routes.dart';
import 'package:fallnews/presentation/features/auth/bloc/auth/auth_bloc.dart';
import 'package:fallnews/presentation/features/auth/bloc/auth/auth_event.dart';
import 'package:fallnews/presentation/features/auth/bloc/auth/auth_state.dart';
import 'package:fallnews/presentation/features/auth/bloc/password_visivility/password_visibility_bloc.dart';
import 'package:fallnews/presentation/widgets/common_text_form_field.dart';
import 'package:fallnews/presentation/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text('Sign In', style: textTheme.headlineMedium)),
      body: Padding(
        padding: EdgeInsets.all(AppDimens.r16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Welcome Back!', style: textTheme.displaySmall),
              SizedBox(height: AppDimens.h8),
              Text('Sign in to continue', style: textTheme.bodyMedium),
              SizedBox(height: AppDimens.h24),
              CommonTextFormField(
                hintText: 'Email',
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: AppDimens.h16),
              BlocProvider(
                create: (_) => PasswordVisibilityBloc(),
                child: CommonTextFormField(
                  hintText: 'Password',
                  controller: passwordController,
                  isPassword: true,
                ),
              ),
              SizedBox(height: AppDimens.h24),
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Login Successful')),
                    );
                    Navigator.pushReplacementNamed(context, AppRoutes.newsHome);
                  } else if (state is AuthFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Login Failed: ${state.error}')),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return PrimaryButton(
                    buttonText: 'Sign In',
                    onPressed: () {
                      context.read<AuthBloc>().add(
                        LoginUser(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
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
                    Navigator.pushNamed(context, AppRoutes.forgotPassword);
                  },
                  child: Text(
                    'Forgot Password?',
                    style: textTheme.titleMedium?.copyWith(
                      color: AppColors.grey,
                    ),
                  ),
                ),
              ),
              SizedBox(height: AppDimens.h16),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.register);
                  },
                  child: Text(
                    'Don\'t have an account? Sign Up',
                    style: textTheme.titleMedium?.copyWith(
                      color: AppColors.grey,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

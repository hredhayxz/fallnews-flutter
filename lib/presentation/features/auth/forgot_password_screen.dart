import 'package:fallnews/core/constant/app_dimens.dart';
import 'package:fallnews/presentation/features/auth/bloc/auth/auth_bloc.dart';
import 'package:fallnews/presentation/features/auth/bloc/auth/auth_event.dart';
import 'package:fallnews/presentation/features/auth/bloc/auth/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fallnews/presentation/widgets/common_text_form_field.dart';
import 'package:fallnews/presentation/widgets/primary_button.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password', style: textTheme.headlineMedium),
      ),
      body: Padding(
        padding: EdgeInsets.all(AppDimens.r16),
        child: Column(
          children: [
            CommonTextFormField(
              hintText: 'Enter your email',
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: AppDimens.h16),
            BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is PasswordResetSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Reset link sent to email')),
                  );
                  Navigator.pop(context);
                } else if (state is PasswordResetFailure) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.error)));
                }
              },
              builder: (context, state) {
                if (state is AuthLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                return PrimaryButton(
                  buttonText: 'Send Reset Link',
                  onPressed: () {
                    context.read<AuthBloc>().add(
                      ForgotPassword(email: emailController.text),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

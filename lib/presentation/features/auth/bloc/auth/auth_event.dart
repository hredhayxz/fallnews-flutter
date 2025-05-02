import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginUser extends AuthEvent {
  final String email;
  final String password;

  LoginUser({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class RegisterUser extends AuthEvent {
  final String name;
  final String email;
  final String password;

  RegisterUser({
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [name, email, password];
}

class LogoutUser extends AuthEvent {
  @override
  List<Object> get props => [];
}

class ForgotPassword extends AuthEvent {
  final String email;

  ForgotPassword({required this.email});

  @override
  List<Object> get props => [email];
}

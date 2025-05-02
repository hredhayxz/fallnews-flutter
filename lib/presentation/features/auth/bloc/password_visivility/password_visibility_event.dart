import 'package:equatable/equatable.dart';

abstract class PasswordVisibilityEvent extends Equatable {
  const PasswordVisibilityEvent();

  @override
  List<Object> get props => [];
}

class TogglePasswordVisibilityEvent extends PasswordVisibilityEvent {}

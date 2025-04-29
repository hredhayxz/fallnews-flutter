import 'package:equatable/equatable.dart';

class PasswordVisibilityState extends Equatable {
  final bool isHidden;

  const PasswordVisibilityState({this.isHidden = true});

  PasswordVisibilityState copyWith({bool? isHidden}) {
    return PasswordVisibilityState(isHidden: isHidden ?? this.isHidden);
  }

  @override
  List<Object> get props => [isHidden];
}

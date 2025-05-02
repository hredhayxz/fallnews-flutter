import 'package:fallnews/presentation/features/auth/bloc/password_visivility/password_visibility_event.dart';
import 'package:fallnews/presentation/features/auth/bloc/password_visivility/password_visibility_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordVisibilityBloc
    extends Bloc<PasswordVisibilityEvent, PasswordVisibilityState> {
  PasswordVisibilityBloc() : super(const PasswordVisibilityState()) {
    on<TogglePasswordVisibilityEvent>((event, emit) {
      emit(state.copyWith(isHidden: !state.isHidden));
    });
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthBloc() : super(AuthInitial()) {
    on<LoginUser>(_onLoginUser);
    on<RegisterUser>(_onRegisterUser);
    on<ForgotPassword>(_onForgotPassword);
    on<LogoutUser>(_onLogoutUser);
  }

  Future<void> _onLoginUser(LoginUser event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _auth.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(e.message ?? 'Login failed'));
    } catch (_) {
      emit(AuthFailure('An unknown error occurred'));
    }
  }

  Future<void> _onRegisterUser(
    RegisterUser event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await _auth.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      await _auth.currentUser?.updateDisplayName(event.name);
      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(e.message ?? 'Registration failed'));
    } catch (_) {
      emit(AuthFailure('An unknown error occurred'));
    }
  }

  Future<void> _onForgotPassword(
    ForgotPassword event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await _auth.sendPasswordResetEmail(email: event.email);
      emit(PasswordResetSuccess());
    } on FirebaseAuthException catch (e) {
      emit(PasswordResetFailure(e.message ?? 'Password reset failed'));
    } catch (_) {
      emit(PasswordResetFailure('An unknown error occurred'));
    }
  }

  Future<void> _onLogoutUser(LogoutUser event, Emitter<AuthState> emit) async {
    try {
      await _auth.signOut();
      emit(AuthInitial());
    } catch (_) {
      emit(AuthFailure('Logout failed'));
    }
  }
}

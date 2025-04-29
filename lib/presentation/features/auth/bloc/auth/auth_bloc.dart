import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthBloc() : super(AuthInitial()) {
    on<LoginUser>(_onLoginUser);
    on<RegisterUser>(_onRegisterUser);
    on<LogoutUser>(_onLogoutUser);
  }

  // Handle user login
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

  // Handle user registration
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

      // Optional: Update the user's display name after registration
      await _auth.currentUser?.updateDisplayName(event.name);

      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(e.message ?? 'Registration failed'));
    } catch (_) {
      emit(AuthFailure('An unknown error occurred'));
    }
  }

  // Handle user logout
  Future<void> _onLogoutUser(LogoutUser event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _auth.signOut();
      emit(AuthLoggedOut());
    } catch (_) {
      emit(AuthFailure('An unknown error occurred during logout'));
    }
  }
}

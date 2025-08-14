import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SupabaseClient _supabase = Supabase.instance.client;

  AuthCubit() : super(AuthInitial());

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  Future<bool> signUpFunction() async {
    emit(AuthLoading());
    try {
      final AuthResponse res = await _supabase.auth.signUp(
        email: emailController.text,
        password: passwordController.text,
      );

      if (res.user != null) {
        print('User is not null, emitting AuthAuthenticated');
        emit(AuthAuthenticated(user: res.user!));
        return true;
      } else {
        print('User is null, emitting AuthError');
        emit(AuthError(message: 'Sign up failed. Please check your details.'));
        return false;
      }
    } on AuthException catch (e) {
      print('Caught AuthException: ${e.message}');
      emit(AuthError(message: e.message));
      return false;
    } catch (e) {
      print('Caught unknown exception: $e');
      emit(AuthError(message: 'An unknown error occurred.'));
      return false;
    }
  }

  Future<bool> logInFunction() async {

    emit(AuthLoading());

    final AuthResponse res = await _supabase.auth.signInWithPassword(
      email: emailController.text,
      password: passwordController.text,
    );

    if (res.user != null) {
      emit(AuthAuthenticated(user: res.user!));
      return true;
    } else {
      emit(
        AuthError(message: 'Sign in failed. Please check your credentials.'),
      );
      return false;
    }
  }
}

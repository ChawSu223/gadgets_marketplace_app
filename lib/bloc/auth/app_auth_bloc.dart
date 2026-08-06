import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gadgets_marketplace/bloc/auth/app_auth_event.dart';
import 'package:gadgets_marketplace/bloc/auth/app_auth_state.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/constants/supabase_client.dart';

class AppAuthBloc extends Bloc<AppAuthEvent, AppAuthState> {
  AppAuthBloc() : super(AuthInitialState()) {
    // Login Event ကို ကိုင်တွယ်ခြင်း
    on<AuthLoginEvent>((event, emit) async {
      emit(AuthLoadingState());
      try {
        final response = await supabase.auth.signInWithPassword(
          email: event.email.trim(),
          password: event.password.trim(),
        );

        if (response.user != null) {
          emit(AuthAuthenticatedState(response.user!));
        } else {
          emit(const AuthErrorState('Login failed'));
        }
      } on AuthException catch (e) {
        emit(AuthErrorState(e.message));
      } catch (e) {
        emit(AuthErrorState('Unexpected error: $e'));
      }
    });

    // Register Event ကို ကိုင်တွယ်ခြင်း
    on<AuthRegisterEvent>((event, emit) async {
      emit(AuthLoadingState());
      try {
        final response = await supabase.auth.signUp(
          email: event.email.trim(),
          password: event.password.trim(),
        );

        if (response.user != null) {
          emit(AuthAuthenticatedState(response.user!));
        } else {
          emit(const AuthErrorState('Registration failed'));
        }
      } on AuthException catch (e) {
        emit(AuthErrorState(e.message));
      } catch (e) {
        emit(AuthErrorState('Unexpected error: $e'));
      }
    });

    // Logout Event ကို ကိုင်တွယ်ခြင်း
    on<AuthLogoutEvent>((event, emit) async {
      emit(AuthLoadingState());
      await supabase.auth.signOut();
      emit(AuthUnauthenticatedState());
    });
  }
}

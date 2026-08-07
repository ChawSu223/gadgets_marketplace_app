import 'package:equatable/equatable.dart';

abstract class AppAuthEvent extends Equatable {
  const AppAuthEvent();

  @override
  List<Object?> get props => [];
}

// Login လုပ်ရန် Event
class AuthLoginEvent extends AppAuthEvent {
  final String email;
  final String password;

  const AuthLoginEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

// Register လုပ်ရန် Event
class AuthRegisterEvent extends AppAuthEvent {
  final String email;
  final String password;

  const AuthRegisterEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

// Logout လုပ်ရန် Event
class AuthLogoutEvent extends AppAuthEvent {}

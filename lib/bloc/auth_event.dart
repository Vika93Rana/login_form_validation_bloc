part of 'auth_bloc.dart';

/// events are basically inputs to our blocs
/// that is why circularloading is in state class and not event class
sealed class AuthEvent {}

final class AuthLoginRequested extends AuthEvent {
  /// this is an input we can give
  final String email;
  final String password;

  AuthLoginRequested({required this.email, required this.password});
}

final class AuthLogoutRequested extends AuthEvent {}

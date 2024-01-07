part of 'auth_bloc.dart';

sealed class AuthState {}

final class AuthInital extends AuthState {}

final class AuthSuccess extends AuthState {
  final String uid; // user model can be init here

  AuthSuccess({required this.uid});

}

final class AuthFailure extends AuthState {
  final String error;

  AuthFailure(this.error);
}
final class AuthLoading extends AuthState{
  /// there are 3 types of state in async data
///
}

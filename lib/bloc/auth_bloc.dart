import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';

part 'auth_state.dart';

/// Bloc needs Event and State as generics

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  /// bloc's const expects a call with init bloc state

  AuthBloc() : super(AuthInital()) {
    on<AuthLoginRequested>(_onAuthLoginRequested);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
  }


  /// these methods can be overridden in BlocObserver class also
  //
  // @override
  // void onChange(Change<AuthState> change) {
  //   // TODO: implement onChange
  //   super.onChange(change);
  //   /// show changes in state in chronology
  //   debugPrint('AuthBloc - $change');
  // }

  // @override
  // void onTransition(Transition<AuthEvent, AuthState> transition) {
    /// this method is present in just Bloc not in Cubit
    /// because it shows the event invoked between the state changes
    /// and Cubit does  not handle the events that is why it is
    /// not present there.
    /// Helpful in many cases - it tells us why the state changed
    /// which event changed the state
    /// because here it is clear that logout/login changed the state
    /// but in big projects it can be from multiple reasons like
    /// token revoked, app crash, etc.
    /// so big projects -> use bloc.
    /// Bloc is also very helpful when you make advanced
    /// event transformations like (reactive operators - Buffered,
    /// Debounce time throttle, etc)
    /// Debounce -> a way of dealing with a function untill a
    /// certain amount has passed
    /// e.g. we don't want a user to click on login button
    /// a hundred times in a second -> that is not a user, it is bot
    /// refrence -> bloc_concurrency pkg -> use it for reactive events
    /// otherwise just USE Cubit
  //   super.onTransition(transition);
  //   debugPrint('AuthBloc  - $transition');
  // }



  void _onAuthLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await Future.delayed(Duration(seconds: 1), () {
        return emit(AuthInital());
      });
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  void _onAuthLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
      /// and Emitter is a class which is capable of emitting
      /// new states
  ) async {
    emit(AuthLoading());

    /// this will be invoked when AuthLoginRequested is called
    /// any screen
    /// now get the email and password and check
    /// their validity but fist we need them here
    /// capture those events and inputs from user
    try {
      final String email = event.email;
      final String password = event.password;
      final bool emailValid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(email);
      if (!emailValid) {
        /// below statement change the state hence BlocListener
        /// will listen to that state change
        return emit(AuthFailure('invalid email'));
      }
      if (password.length < 6) {
        return emit(AuthFailure("Password cannot be less than 6 chars"));
      }

      await Future.delayed(const Duration(seconds: 1), () {
        return emit(AuthSuccess(uid: '$email-$password'));
      });
    } catch (e) {
      return emit(AuthFailure(e.toString()));
    }
  }
}

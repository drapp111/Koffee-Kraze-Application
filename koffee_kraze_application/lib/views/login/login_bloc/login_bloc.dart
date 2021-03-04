import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:koffee_kraze_application/views/login/models/password.dart';
import 'package:koffee_kraze_application/views/login/models/username.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    @required AuthenticationRepository authenticationRepository,
  })  : assert(authenticationRepository != null),
        _authenticationRepository = authenticationRepository,
        super(const LoginState());

  final AuthenticationRepository _authenticationRepository;

  @override
  Stream<LoginState> mapEventToState(
      LoginEvent event,
      ) async* {
    if (event is LoginUsernameChanged) {
      yield _mapUsernameChangedToState(event, state);
    } else if (event is LoginPasswordChanged) {
      yield _mapPasswordChangedToState(event, state);
    } else if (event is RequestNewCode) {
      _mapRequestNewCodeToState(event, state);
    } else if (event is ConfirmationSubmitted) {
      yield* _mapCodeSubmittedToState(event, state, event.confirmCode);
    } else if (event is LoginSubmitted) {
      yield* _mapLoginSubmittedToState(event, state);
    }
  }
  LoginState _mapUsernameChangedToState(
      LoginUsernameChanged event,
      LoginState state,
      ) {
    final username = Username.dirty(event.username);
    return state.copyWith(
      username: username,
      status: Formz.validate([state.password, username]),
    );
  }

  LoginState _mapPasswordChangedToState(
      LoginPasswordChanged event,
      LoginState state,
      ) {
    final password = Password.dirty(event.password);
    return state.copyWith(
      password: password,
      status: Formz.validate([password, state.username]),
    );
  }

  bool _mapRequestNewCodeToState(
      RequestNewCode event,
      LoginState state,
      ) {
    if(state.username.value == null) {
      return false;
    }
    _authenticationRepository.newConfirmationCode(username: state.username.value);
    return true;
  }

  Stream<LoginState> _mapLoginSubmittedToState(
      LoginSubmitted event,
      LoginState state,
      ) async* {
    if (state.status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      try {
        AuthenticationStatus status = await _authenticationRepository.logIn(
          username: state.username.value,
          password: state.password.value,
        );
        if(status == AuthenticationStatus.unconfirmed) {
          print("User unconfirmed");
          yield state.copyWith(confirmed: false);
        }
        else if(status == AuthenticationStatus.unauthenticated) {
          print("User not authenticated");
          yield state.copyWith(status: FormzStatus.submissionFailure);
        }
        else if(status == AuthenticationStatus.authenticated) {
          print("User authenticated");
          yield state.copyWith(status: FormzStatus.submissionSuccess);
        }
      } catch (error) {
        print("Error: login_bloc: _mapLoginSubmittedToState");
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }
    }
  }

  Stream<LoginState> _mapCodeSubmittedToState(
      ConfirmationSubmitted event,
      LoginState state,
      String confirmCode,
      ) async* {
    try {
      _authenticationRepository.confirmRegistration(username: state.username.value, password: state.password.value, confirmCode: confirmCode);
      yield state.copyWith(confirmed: true);
    } catch (error) {
      print("Error: login_bloc: _mapCodeSubmittedToState");
      yield state.copyWith(confirmed: false);
    }
  }
}
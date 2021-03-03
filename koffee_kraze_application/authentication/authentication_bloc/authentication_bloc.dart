import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:user_repository/user_repository.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

/*
Purpose: Handles authentication flow within the application, specifically user
authentication state as defined by the enum { authenticated, unauthenticated,
unconfirmed, unknown }
Details: Class is built with bloc structure for handling events and states that
are entered into the stream by the application. Each bloc contains three
separate classes that handle different functions. authentication_bloc handles
the processing of events that are raised by the application. auth
 */

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    @required AuthenticationRepository authenticationRepository,
    @required UserRepository userRepository,
    //Determines that the repositories have been initialized
  })  : assert(authenticationRepository != null),
        assert(userRepository != null),
        _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
  //Sets the state to unknown to begin with then builds a stream which
  // subscribes to the authentication status and adds an event on change
        super(const AuthenticationState.unknown()) {
    _authenticationStatusSubscription = _authenticationRepository.status.listen(
          (status) => add(AuthenticationStatusChanged(status)),
    );
  }

  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  StreamSubscription<AuthenticationStatus> _authenticationStatusSubscription;

  /*
  Purpose: Maps the logged events to a state to fulfill the request
  Post: Requests are passed along to the proper methods for response
   */
  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event,
      ) async* {
    if (event is AuthenticationStatusChanged) {
      yield await _mapAuthenticationStatusChangedToState(event);
    } else if (event is AuthenticationLogoutRequested) {
      _authenticationRepository.logOut();
    }
  }

  /*
  Purpose: Close the stream so that there is not a memory leak due to open
  stream
  Post:  Stream is closed at the end of the usage of the bloc
  Details: This is a required method to avoid memory leakage and other
  assorted issues
   */

  @override
  Future<void> close() {
    _authenticationStatusSubscription?.cancel();
    _authenticationRepository.dispose();
    return super.close();
  }

  /*
  Purpose: When the authentication status changes, this method handles the
  request and provides action based on the change
  Post: If the status is unauthenticated, the method returns an
  unauthenticated user state, if the user is authenticated then the method
  attempts to retrieve current user. If the current user does not exist then
  the method returns unauthenticated, otherwise returns authenticated with
  the user object. Defaults to unknown.
   */

  Future<AuthenticationState> _mapAuthenticationStatusChangedToState(
      AuthenticationStatusChanged event,
      ) async {
    //Determines response based on case
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
      //returns unauthenticated status
        return const AuthenticationState.unauthenticated();
      case AuthenticationStatus.authenticated:
      //Tries to retrieve the current user
        final user = await _tryGetUser();
        //Determines return based on user object
        return user != null
            ? AuthenticationState.authenticated(user)
            : const AuthenticationState.unauthenticated();
      default:
        return const AuthenticationState.unknown();
    }
  }

  /*
  Purpose: Retrieves the current user from the UserRepository or null
  Post: Returns a HaloUser object or null
   */

  Future<User> _tryGetUser() async {
    try {
      final user = await _userRepository.getCurrentUser();
      return user;
    } on Exception {
      return null;
    }
  }
}
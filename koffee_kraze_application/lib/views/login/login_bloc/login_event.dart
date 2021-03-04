part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginUsernameChanged extends LoginEvent {
  const LoginUsernameChanged(this.username);

  final String username;

  @override
  List<Object> get props => [username];
}

class LoginPasswordChanged extends LoginEvent {
  const LoginPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class LoginSubmitted extends LoginEvent {
  const LoginSubmitted();
}

class RequestNewCode extends LoginEvent {
  const RequestNewCode();
}

class ConfirmationSubmitted extends LoginEvent {
  const ConfirmationSubmitted(this.confirmCode);

  final String confirmCode;

  @override
  List<Object> get props => [confirmCode];
}
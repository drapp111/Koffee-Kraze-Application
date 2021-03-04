import 'dart:async';
import 'package:meta/meta.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated, unconfirmed }

class AuthenticationRepository {
  StreamController<AuthenticationStatus> _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.authenticated;
    yield* _controller.stream;
  }

  Future getCurrentUser() async {

  }

  Future logIn({
    @required String username,
    @required String password,
  }) async {
    assert(username != null);
    assert(password != null);
  }

  Future createUserEmailPassword({
    @required String email,
    @required String password,
    Map<String, dynamic> userData,
  }) async {
    assert(email != null);
    assert(password != null);
  }

  Future confirmRegistration({
    @required String username,
    @required String password,
    @required String confirmCode,
  }) async {
    assert(username != null);
    assert(confirmCode != null);
  }

  Future newConfirmationCode({
    @required String username,
  }) async {
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
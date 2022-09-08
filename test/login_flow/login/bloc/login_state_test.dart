import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';

import '../../../../lib_login_flow/login/login.dart';

void main() {
  const username = Username.dirty('username');
  const password = Password.dirty('password');
  group('Login State', () {
    test('support value comparison', () {
      expect(const LoginState(), const LoginState());
    });

    test('return same object when n properties are passed', () {
      expect(const LoginState().copyWith(), const LoginState());
    });

    test('returns object with updated status when status is passed', () {
      expect(
        const LoginState().copyWith(status: FormzStatus.pure),
        const LoginState(),
      );
    });

    test('returns object with updated username when username is passed', () {
      expect(const LoginState().copyWith(username: username),
          const LoginState(username: username));
    });

    test('returns object with updated password when password is passed', () {
      expect(
        const LoginState().copyWith(password: password),
        const LoginState(password: password),
      );
    });
  });
}

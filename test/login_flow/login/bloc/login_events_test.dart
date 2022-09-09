import 'package:flutter_test/flutter_test.dart';

import '../../../../lib_login_flow/login/login.dart';

void main() {
  const username = 'test username';
  const password = 'test password';
  group('Login Event', () {
    group('LoginUsernameChanged', () {
      test('supports value comparisons', () {
        expect(
          const LoginUsernameChanged(username),
          const LoginUsernameChanged(username),
        );
      });
    });

    group('LoginPassWordChanged', () {
      test('supports value comparisons', () {
        expect(
          const LoginPasswordChanged(password),
          const LoginPasswordChanged(password),
        );
      });
    });

    group('LoginSubmitted', () {
      test('support value comparison', () {
        expect(
          const LoginSubmitted(),
          const LoginSubmitted(),
        );
      });
    });
  });
}

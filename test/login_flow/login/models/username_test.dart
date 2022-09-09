import 'package:flutter_test/flutter_test.dart';

import '../../../../lib_login_flow/login/login.dart';

void main() {
  const mock_username = 'mock-username';

  group('Username', () {
    group('constructors', () {
      test('pure creates correct instance', () {
        const username = Username.pure();
        expect(username.value, '');
        expect(username.pure, true);
      });

      test('dirty creates correct instance', () {
        const username = Username.dirty(mock_username);
        expect(username.value, mock_username);
        expect(username.pure, false);
      });
    });

    group('validator', () {
      test('returns empty error when username is empty', () {
        expect(
          const Username.dirty().error,
          UserNameValidationError.empty,
        );
      });

      test('is valid when username is not empty', () {
        expect(
          const Username.dirty(mock_username).error,
          isNull,
        );
      });
    });
  });
}

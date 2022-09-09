import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../lib_login_flow/authentication/bloc/authentication_bloc.dart';

void main() {
  group('AuthenticationEvent', () {
    group('AuthenticatedStateChanged', () {
      test('support value comparison', () {
        expect(
          const AuthenticationStatusChanged(AuthenticationStatus.unknown),
          const AuthenticationStatusChanged(AuthenticationStatus.unknown),
        );
      });
    });

    group('AuthenticationLogoutRequest', () {
      test('support vaule comparison', () {
        expect(
          AuthenticationLogoutRequest(),
          AuthenticationLogoutRequest(),
        );
      });
    });
  });
}

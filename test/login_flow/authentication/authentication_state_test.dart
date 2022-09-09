import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:user_repository/user_repository.dart';

import '../../../lib_login_flow/authentication/bloc/authentication_bloc.dart';

class MockUser extends Mock implements User {}

void main() {
  late User user;

  setUp(() {
    user = MockUser();
  });

  group('AuthenticationState', () {
    group('AuthenticationState.unknown', () {
      test('support value comparison', () {
        expect(
          const AuthenticationState.unknown(),
          const AuthenticationState.unknown(),
        );
      });
    });

    group('AuthenticationState.unauthenticated', () {
      test('support value comparison', () {
        expect(
          const AuthenticationState.unauthenticated(),
          const AuthenticationState.unauthenticated(),
        );
      });
    });

    group('AuthenticatedState.authenticated', () {
      test('support value comparison', () {
        expect(
          AuthenticationState.authenticated(user),
          AuthenticationState.authenticated(user),
        );
      });
    });
  });
}

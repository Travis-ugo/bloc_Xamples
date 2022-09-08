import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../lib_login_flow/login/login.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  late AuthenticationRepository authenticationRepository;

  setUp(() {
    authenticationRepository = MockAuthenticationRepository();
  });

  group('Login Bloc', () {
    test('initial state is LoginState', () {
      final loginBloc =
          LoginBloc(authenticationRepository: authenticationRepository);
      expect(loginBloc.state, const LoginState());
    });
  });
}

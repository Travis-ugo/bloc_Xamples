import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../lib_login_flow/login/login.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  group('LoginPage', () {
    late AuthenticationRepository authenticationRepository;

    setUp(() {
      authenticationRepository = MockAuthenticationRepository();
    });

    test('is routable', () {
      expect(LoginPage.route(), isA<MaterialPageRoute<void>>());
    });

    testWidgets('', (tester) async {
      await tester.pumpWidget(RepositoryProvider.value(
        value: authenticationRepository,
        child: const MaterialApp(
          home: Scaffold(
            body: LoginPage(),
          ),
        ),
      ));

      expect(find.byType(LoginForm), findsOneWidget);
    });
  });
}

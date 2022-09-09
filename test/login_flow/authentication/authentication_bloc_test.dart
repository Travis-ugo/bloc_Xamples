import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:user_repository/user_repository.dart';

import '../../../lib_login_flow/authentication/authentication.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  const user = User('id');
  late AuthenticationRepository authenticationRepository;
  late UserRepository userRepository;

  setUp(() {
    authenticationRepository = MockAuthenticationRepository();
    userRepository = MockUserRepository();

    when(() => authenticationRepository.status)
        .thenAnswer((_) => const Stream.empty());
  });

  group('AuthenticationBloc', () {
    test('initialState is AuthenticatedState.unknown', () {
      final authenticationState = AuthenticationBloc(
          userRepository: userRepository,
          authenticationRepository: authenticationRepository);
      expect(authenticationState.state, const AuthenticationState.unknown());

      authenticationState.close();
    });

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [unauthenticated] when status is unauthenticated',
      setUp: (() {
        when(() => authenticationRepository.status).thenAnswer(
          (_) => Stream.value(AuthenticationStatus.unauthenticated),
        );
      }),
      build: () => AuthenticationBloc(
        userRepository: userRepository,
        authenticationRepository: authenticationRepository,
      ),
      expect: () => <AuthenticationState>[
        const AuthenticationState.unauthenticated(),
      ],
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [authenticated] when status is authenticated',
      setUp: (() {
        when(() => authenticationRepository.status).thenAnswer(
          (_) => Stream.value(AuthenticationStatus.authenticated),
        );
        when(() => userRepository.getUser()).thenAnswer((_) async => user);
      }),
      build: () => AuthenticationBloc(
        userRepository: userRepository,
        authenticationRepository: authenticationRepository,
      ),
      expect: () => <AuthenticationState>[
        const AuthenticationState.authenticated(user),
      ],
    );
  });

  group('AuthenticationStatusChanged', () {
    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [authenticated] when status is authenticated',
      setUp: (() {
        when(() => authenticationRepository.status).thenAnswer(
          (_) => Stream.value(AuthenticationStatus.authenticated),
        );
        when(() => userRepository.getUser()).thenAnswer((_) async => user);
      }),
      act: (bloc) => bloc.add(
        const AuthenticationStatusChanged(AuthenticationStatus.authenticated),
      ),
      build: () => AuthenticationBloc(
        userRepository: userRepository,
        authenticationRepository: authenticationRepository,
      ),
      expect: () => <AuthenticationState>[
        const AuthenticationState.authenticated(user),
      ],
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [unauthenticated] when status is unauthenticated',
      setUp: (() {
        when(() => authenticationRepository.status).thenAnswer(
            (_) => Stream.value(AuthenticationStatus.unauthenticated));
      }),
      build: () => AuthenticationBloc(
        userRepository: userRepository,
        authenticationRepository: authenticationRepository,
      ),
      act: (bloc) => bloc.add(
        const AuthenticationStatusChanged(AuthenticationStatus.unauthenticated),
      ),
      expect: () => const <AuthenticationState>[
        AuthenticationState.unauthenticated(),
      ],
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [unauthenticated] when status is authenticated but getUser fails',
      setUp: (() {
        when(() => userRepository.getUser()).thenThrow(Exception('oops'));
      }),
      build: () => AuthenticationBloc(
        authenticationRepository: authenticationRepository,
        userRepository: userRepository,
      ),
      act: (bloc) => bloc.add(
        const AuthenticationStatusChanged(AuthenticationStatus.authenticated),
      ),
      expect: () => const <AuthenticationState>[
        AuthenticationState.unauthenticated(),
      ],
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [unauthenticated] when status is authenticated '
      'but getUser returns null',
      setUp: (() {
        when(() => authenticationRepository.status).thenAnswer(
          (_) => Stream.value(AuthenticationStatus.authenticated),
        );
        when(() => userRepository.getUser()).thenAnswer((_) async => null);
      }),
      build: () => AuthenticationBloc(
        authenticationRepository: authenticationRepository,
        userRepository: userRepository,
      ),
      act: (bloc) => bloc.add(
        const AuthenticationStatusChanged(AuthenticationStatus.authenticated),
      ),
      expect: () => const <AuthenticationState>[
        AuthenticationState.unauthenticated(),
      ],
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [unknown] when status is unknown',
      setUp: (() {
        when(() => authenticationRepository.status).thenAnswer(
          (_) => Stream.value(AuthenticationStatus.unknown),
        );
      }),
      build: () => AuthenticationBloc(
        userRepository: userRepository,
        authenticationRepository: authenticationRepository,
      ),
      act: (bloc) => bloc.add(
        const AuthenticationStatusChanged(AuthenticationStatus.unknown),
      ),
      expect: () => const <AuthenticationState>[
        AuthenticationState.unknown(),
      ],
    );
  });

  group('AuthenticationLogoutRequested', () {
    blocTest<AuthenticationBloc, AuthenticationState>(
      'calls logOut on authenticationRepository '
      'when AuthenticationLogoutRequested is added',
      build: () => AuthenticationBloc(
        userRepository: userRepository,
        authenticationRepository: authenticationRepository,
      ),
      act: (bloc) => bloc.add(AuthenticationLogoutRequest()),
      verify: (_) {
        verify(() => authenticationRepository.logout()).called(1);
      },
    );
  });
}

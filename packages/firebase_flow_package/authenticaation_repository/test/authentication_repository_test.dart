import 'package:authentication_repository/src/authentication_repository.dart';
import 'package:authentication_repository/src/models/models.dart';
import 'package:cache/cache.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:firebase_auth_platform_interface/src/auth_provider.dart';

const _mockFirebaseUserUid = 'mock_uid';
const _mockFirebaseEmail = 'mock_email';

class MockCacheClient extends Mock implements CacheClient {}

class MockFirebaseAuth extends Mock implements firebase_auth.FirebaseAuth {}

class MockFirebaseCore extends Mock
    with MockPlatformInterfaceMixin
    implements FirebasePlatform {}

class MockFirebaseUser extends Mock implements firebase_auth.User {}

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

class MockGoogleSignInAccount extends Mock implements GoogleSignInAccount {}

class MockGoogleSignInAuthentication extends Mock
    implements GoogleSignInAuthentication {}

class MockUserCredential extends Mock implements firebase_auth.UserCredential {}

class FakeAuthCredential extends Fake implements firebase_auth.AuthCredential {}

class FakeAuthProvider extends Fake implements AuthProvider {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const email = 'test@gmail.com';
  const password = 't0ps3cret42';

  const user = User(
    id: _mockFirebaseUserUid,
    email: _mockFirebaseEmail,
  );

  group('AuthenticationRepository', () {
    late CacheClient cache;
    late firebase_auth.FirebaseAuth firebaseAuth;
    late GoogleSignIn googleSignIn;
    late AuthenticationRepository authenticationRepository;

    setUpAll(() {
      registerFallbackValue(FakeAuthCredential());
      registerFallbackValue(FakeAuthProvider());
    });

    setUp(() {
      const options = FirebaseOptions(
        apiKey: 'apiKey',
        appId: 'appId',
        projectId: 'projectId',
        messagingSenderId: 'messagingSenderId',
      );

      final platformApp = FirebaseAppPlatform(defaultFirebaseAppName, options);
      final firebaseCore = MockFirebaseCore();

      when(() => firebaseCore.apps).thenReturn([platformApp]);
      when(firebaseCore.app).thenReturn(platformApp);

      when(
        () => firebaseCore.initializeApp(
          name: defaultFirebaseAppName,
          options: options,
        ),
      ).thenAnswer((_) async => platformApp);

      Firebase.delegatePackingProperty = firebaseCore;

      cache = MockCacheClient();
      firebaseAuth = MockFirebaseAuth();
      googleSignIn = MockGoogleSignIn();
      authenticationRepository = AuthenticationRepository(
        cache: cache,
        firebaseAuth: firebaseAuth,
        googleSignIn: googleSignIn,
      );
    });

    test('creates FirebaseAuth instance internally when not injected', () {
      expect(AuthenticationRepository.new, isNot(throwsException));
    });

    group('SignUp', () {
      setUp(() {
        when(
          () => firebaseAuth.createUserWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) => Future.value(MockUserCredential()));
      });

      test('calls createUserWithEmailAndPassword', () async {
        await authenticationRepository.signUp(
          email: email,
          password: password,
        );

        verify(
          () => firebaseAuth.createUserWithEmailAndPassword(
            email: email,
            password: password,
          ),
        ).called(1);
      });

      test('succeeds when createUserWithEmailAndPassword succeeds', () async {
        expect(
          authenticationRepository.signUp(
            email: email,
            password: password,
          ),
          completes,
        );
      });

      test(
        'throws SignUpWithEmailAndPasswordFailure '
        'when createUserWithEmailAndPassword throws',
        () {
          when(() => firebaseAuth.createUserWithEmailAndPassword(
                email: any(named: 'email'),
                password: any(named: 'password'),
              )).thenThrow(Exception());

          expect(
            authenticationRepository.signUp(
              email: email,
              password: password,
            ),
            throwsA(isA<SignUpWithEmailAndPasswordFailure>()),
          );
        },
      );
    });

    group('LoginWithGoogle', () {
      const accessToken = 'access-token';
      const idToken = 'id-token';

      setUp(() {
        final googleSignInAccount = MockGoogleSignInAccount();
        final googleSignInAuthentication = MockGoogleSignInAuthentication();

        when(() => googleSignInAuthentication.accessToken)
            .thenReturn(accessToken);

        when(() => googleSignInAuthentication.idToken).thenReturn(idToken);

        when(() => googleSignInAccount.authentication)
            .thenAnswer((_) async => googleSignInAuthentication);

        when(() => googleSignIn.signIn())
            .thenAnswer((_) async => googleSignInAccount);

        when(() => firebaseAuth.signInWithCredential(any()))
            .thenAnswer((_) => Future.value(MockUserCredential()));

        when(() => firebaseAuth.signInWithPopup(any()))
            .thenAnswer((_) => Future.value(MockUserCredential()));
      });

      test('calls signIn authentication, and signInWithCredential', () async {
        await authenticationRepository.loginWithGoogle();
        verify(() => googleSignIn.signIn()).called(1);
        verify(() => firebaseAuth.signInWithCredential(any())).called(1);
      });

      test('succeeds when signIn withGoogle succeeds', () {
        expect(authenticationRepository.loginWithGoogle(), completes);
      });

      test('throws auth failure when error occurs', () {
        when(() => firebaseAuth.signInWithCredential(any()))
            .thenThrow(Exception());

        expect(
          authenticationRepository.loginWithGoogle(),
          throwsA(isA<LoginWithGoogleFailure>()),
        );
      });
    });

    group('login with email and password', () {
      setUp(() {
        when(
          () => firebaseAuth.signInWithEmailAndPassword(
              email: any(named: 'email'), password: any(named: 'password')),
        ).thenAnswer((_) => Future.value(MockUserCredential()));
      });

      test('calls signInWithEmailAndPassword', () async {
        await authenticationRepository.loginWithEmailAndPassword(
            email: email, password: password);

        verify(() => firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password)).called(1);
      });

      test('succeeds when signInWithEmailAndPassword succeeds', () {
        expect(
          authenticationRepository.loginWithEmailAndPassword(
              email: email, password: password),
          completes,
        );
      });

      test(
          'throws LogInWithEmailAndPasswordFailure '
          'when signInWithEmailAndPassword throws', () {
        when(
          () => firebaseAuth.signInWithEmailAndPassword(
              email: any(named: 'email'), password: any(named: 'password')),
        ).thenThrow(Exception());

        expect(
          authenticationRepository.loginWithEmailAndPassword(
              email: email, password: password),
          throwsA(
            isA<LoginWithEmailAndPasswordFailure>(),
          ),
        );
      });
    });
    group('logOut', () {
      test('calls signOut', () async {
        when(() => firebaseAuth.signOut()).thenAnswer((_) async {});
        when(() => googleSignIn.signOut()).thenAnswer((_) async => null);
        await authenticationRepository.logOut();
        verify(() => firebaseAuth.signOut()).called(1);
        verify(() => googleSignIn.signOut()).called(1);
      });

      test('throws LogOutFailure when signOut throws', () {
        when(() => firebaseAuth.signOut()).thenThrow(Exception());
        expect(
          authenticationRepository.logOut(),
          throwsA(isA<LogOutFailure>()),
        );
      });
    });

    group('User', () {
      test('emits User.empty when firebase is null', () async {
        when(() => firebaseAuth.authStateChanges())
            .thenAnswer((_) => Stream.value(null));
        await expectLater(authenticationRepository.user,
            emitsInOrder(const <User>[User.empty]));
      });

      test('emits User when firebase user is not null', () async {
        final firebaseUser = MockFirebaseUser();
        when(() => firebaseUser.uid).thenReturn(_mockFirebaseUserUid);
        when(() => firebaseUser.email).thenReturn(_mockFirebaseEmail);
        when(() => firebaseUser.photoURL).thenReturn(null);
        when(() => firebaseAuth.authStateChanges())
            .thenAnswer((_) => Stream.value(firebaseUser));
        await expectLater(
          authenticationRepository.user,
          emitsInOrder(const <User>[user]),
        );

        verify(
          () => cache.write(
              key: AuthenticationRepository.userCacheKey, value: user),
        ).called(1);
      });
    });

    group('current User', () {
      test('return User.empty when cache is null', () {
        when(() => cache.read(key: AuthenticationRepository.userCacheKey))
            .thenReturn(null);
        expect(authenticationRepository.currentUser, equals(User.empty));
      });

      test('return users when cached user is not null', () {
        when(() => cache.read<User>(key: AuthenticationRepository.userCacheKey))
            .thenReturn(user);

        expect(authenticationRepository.currentUser, equals(user));
      });
    });
  });
}

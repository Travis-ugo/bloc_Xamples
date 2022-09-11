import 'package:firebase_flow/authentication_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('User', () {
    const id = 'mock_id';
    const email = 'mock_username';

    test('uses value equality', () {
      expect(
        const User(id: id, email: email),
        equals(const User(id: id, email: email)),
      );
    });

    test('isEmpty returns true', () {
      expect(User.empty.isEmpty, isTrue);
    });

    test('empty returns false for non-empty user', () {
      expect(const User(id: id, email: email).isEmpty, isFalse);
    });

    test('isNotEmpty returns false for empty user', () {
      expect(User.empty.isNotEmpty, isFalse);
    });

    test('isNotEmpty returns true for non-empty user', () {
      expect(const User(id: id, email: email).isNotEmpty, isTrue);
    });
  });
}

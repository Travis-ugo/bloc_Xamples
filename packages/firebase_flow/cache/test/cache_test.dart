import 'package:cache/cache.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Cache Client', () {
    test('can write and read value for a given key', () {
      final cache = CacheClient();
      const key = '__key__';
      const value = '__value__';

      expect(cache.read(key: key), isNull);
      cache.write(key: key, value: value);
      expect(cache.read(key: key), equals(value));
    });
  });
}

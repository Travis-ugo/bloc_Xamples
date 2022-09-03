import 'package:flutter_test/flutter_test.dart';

import '../../../lib_infinite_list/post/models/post.dart';

void main() {
  group('Models Posts', () {
    test('support comparison', () {
      expect(
        const Post(id: 1, title: 'post title', body: 'post body'),
        const Post(id: 1, title: 'post title', body: 'post body'),
      );
    });
  });
}

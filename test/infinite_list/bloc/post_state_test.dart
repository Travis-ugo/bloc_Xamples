import 'package:flutter_test/flutter_test.dart';

import '../../../lib_infinite_list/post/bloc/post_bloc.dart';

void main() {
  group('PostState', () {
    test('support value comparison', () {
      expect(
        const PostState(),
        const PostState(),
      );
      expect(
        const PostState().toString(),
        const PostState().toString(),
      );
    });
  });
}

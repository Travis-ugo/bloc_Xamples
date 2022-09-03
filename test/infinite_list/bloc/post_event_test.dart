import 'package:flutter_test/flutter_test.dart';

import '../../../lib_infinite_list/post/bloc/post_bloc.dart';

void main() {
  group('PostEvent', () {
    group('PostFetched', () {
      test('support value comparison', () {
        expect(PostFetched(), PostFetched());
      });
    });
  });
}

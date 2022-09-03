import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../lib_infinite_list/post/view/post_list.dart';
import '../../../lib_infinite_list/post/view/post_pages.dart';

void main() {
  group('PostList', () {
    testWidgets(
      'renders PostList',
      (WidgetTester tester) async {
        await tester.pumpWidget(const MaterialApp(home: PostsPage()));
        await tester.pumpAndSettle();
        expect(find.byType(PostsList), findsOneWidget);
      },
    );
  });
}

import 'package:flutter_test/flutter_test.dart';

import '../../lib_infinite_list/app.dart';
import '../../lib_infinite_list/post/view/post_pages.dart';

void main() {
  group('App', () {
    testWidgets('render PostList', (tester) async {
      await tester.pumpWidget(const App());
      await tester.pumpAndSettle();
      expect(find.byType(PostsPage), findsOneWidget);
    });
  });
}

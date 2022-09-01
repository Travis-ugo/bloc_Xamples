import 'package:flutter_test/flutter_test.dart';

import '../../lib_timer/app.dart';
import '../../lib_timer/timer/timer.dart';

void main() {
  group('app test', () {
    testWidgets('render TimerPage widget', (WidgetTester tester) async {
      await tester.pumpWidget(const MyAppTimer());
      expect(find.byType(TimerPage), findsOneWidget);
    });
  });
}

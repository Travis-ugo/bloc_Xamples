import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_xamples/main.dart' as app;

const _incrementButtonKey = Key('counterView_increment_button');
const _decrementButtonKey = Key('counterView_decrement_button');
void main() {
  group('CounterApp', () {
    testWidgets('', (WidgetTester tester) async {
      await tester.pumpApp();
      expect(find.text('Counter'), findsOneWidget);
    });

    testWidgets('renders correct initial count value',
        (WidgetTester tester) async {
      await tester.pumpApp();
      expect(find.text('0'), findsOneWidget);
    });

    testWidgets('tapping increment button, to update count',
        (WidgetTester tester) async {
      await tester.pumpApp();

      await tester.incrementCounter();
      expect(find.text('1'), findsOneWidget);

      await tester.incrementCounter();
      expect(find.text('2'), findsOneWidget);

      await tester.incrementCounter();
      expect(find.text('3'), findsOneWidget);
    });

    testWidgets('tap decrement button to update count',
        (WidgetTester tester) async {
      await tester.pumpApp();

      await tester.decrementCounter();
      expect(find.text('-1'), findsOneWidget);

      await tester.decrementCounter();
      expect(find.text('-2'), findsOneWidget);

      await tester.decrementCounter();
      expect(find.text('-3'), findsOneWidget);
    });

    testWidgets(
        'tapping on increment and decrement button to change counter state',
        (WidgetTester tester) async {
      await tester.pumpApp();

      await tester.incrementCounter();
      expect(find.text('1'), findsOneWidget);

      await tester.incrementCounter();
      expect(find.text('2'), findsOneWidget);

      await tester.decrementCounter();
      expect(find.text('1'), findsOneWidget);
    });
  });
}

extension on WidgetTester {
  Future<void> pumpApp() async {
    app.main();
    await pumpAndSettle();
  }

  Future<void> incrementCounter() async {
    await tap(find.byKey(_incrementButtonKey));
    await pump();
  }

  Future<void> decrementCounter() async {
    await tap(find.byKey(_decrementButtonKey));
    await pump();
  }
}

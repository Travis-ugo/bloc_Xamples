import 'package:bloc_xamples/app.dart';
import 'package:bloc_xamples/counter/view/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'Counter App',
    () {
      testWidgets('is a material App', (WidgetTester tester) async {
        expect(const CounterApp(), isA<MaterialApp>());
      });
      testWidgets('home is CounterPage widget', (WidgetTester tester) async {
        expect(const CounterApp().home, isA<CounterPage>());
      });

      testWidgets('renders counter page', (WidgetTester tester) async {
        await tester.pumpWidget(const CounterApp());
        expect(find.byType(CounterPage), findsOneWidget);
      });
    },
  );
}

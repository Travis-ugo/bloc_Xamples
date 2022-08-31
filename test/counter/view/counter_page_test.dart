import 'package:bloc_xamples/counter/counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'Counter page',
    () {
      testWidgets(
        'render counter page widget',
        (WidgetTester test) async {
          await test.pumpWidget(const MaterialApp(home: CounterPage()));
          expect(find.byType(CounterView), findsOneWidget);
        },
      );
    },
  );
}

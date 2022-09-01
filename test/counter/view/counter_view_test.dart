import 'package:bloc_test/bloc_test.dart';
import 'package:bloc_xamples/counter/counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCounterCubit extends MockCubit<int> implements CounterCubit {}

const _incrementButtonKey = Key('counterView_increment_button');
const _decrementButtonKey = Key('counterView_decrement_button');

void main() {
  late CounterCubit counterCubit;

  setUp(() {
    counterCubit = MockCounterCubit();
  });

  group(
    'CounterView',
    () {
      testWidgets(
        'renders current cubit state',
        (WidgetTester tester) async {
          when(() => counterCubit.state).thenReturn(40);
          await tester.pumpWidget(
            MaterialApp(
              home: BlocProvider.value(
                value: counterCubit,
                child: const CounterView(),
              ),
            ),
          );
          expect(find.text('40'), findsOneWidget);
        },
      );
      testWidgets(
        'tapping increment button invokes increment',
        (WidgetTester tester) async {
          when(() => counterCubit.state).thenReturn(0);
          when(() => counterCubit.increment()).thenReturn(null);
          await tester.pumpWidget(
            MaterialApp(
              home: BlocProvider.value(
                value: counterCubit,
                child: const CounterView(),
              ),
            ),
          );
          await tester.tap(find.byKey(_incrementButtonKey));
          verify(() => counterCubit.increment()).called(1);
        },
      );

      testWidgets(
        'tapping decrement button invokes decrement',
        (WidgetTester tester) async {
          when(() => counterCubit.state).thenReturn(0);
          when(() => counterCubit.decrement()).thenReturn(null);
          await tester.pumpWidget(
            MaterialApp(
              home: BlocProvider.value(
                value: counterCubit,
                child: const CounterView(),
              ),
            ),
          );
          final decrementFinder = find.byKey(_decrementButtonKey);
          await tester.ensureVisible(decrementFinder);
          await tester.tap(decrementFinder);
          verify(() => counterCubit.decrement()).called(1);
        },
      );
    },
  );
}

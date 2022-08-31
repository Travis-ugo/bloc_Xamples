import 'package:bloc_xamples/counter/cubit/counter_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  group(
    'Counter cubit',
    () {
      test('initial state equal is 0', () {
        expect(CounterCubit().state, 0);
      });

      group(
        'increment function',
        () {
          blocTest<CounterCubit, int>(
            'emits [1] when state is 0',
            build: CounterCubit.new,
            act: (cubit) => cubit.increment(),
            expect: () => const <int>[1],
          );
          blocTest<CounterCubit, int>(
            'emits [1, 2] when state is 0',
            build: CounterCubit.new,
            act: (cubit) => cubit
              ..increment()
              ..increment(),
            expect: () => const <int>[1, 2],
          );

          blocTest<CounterCubit, int>(
            'emits [41] when state is 40',
            build: CounterCubit.new,
            seed: () => 40,
            act: (cubit) => cubit.increment(),
            expect: () => const <int>[41],
          );
        },
      );

      group(
        'decrement functions',
        () {
          blocTest<CounterCubit, int>(
            'emits [-1] when state is 0',
            build: CounterCubit.new,
            act: (cubit) => cubit.decrement(),
            expect: () => const <int>[-1],
          );
          blocTest<CounterCubit, int>(
            'emits [-1, -2] when state is 0, decrement is called twice',
            build: CounterCubit.new,
            act: (cubit) => cubit
              ..decrement()
              ..decrement(),
            expect: () => const <int>[-1, -2],
          );
          blocTest<CounterCubit, int>(
            'emits [-1, 0, 1] when state is 0',
            build: CounterCubit.new,
            act: (cubit) => cubit
              ..decrement()
              ..increment()
              ..increment(),
            expect: () => const <int>[-1, 0, 1],
          );

          blocTest<CounterCubit, int>(
            'emit [39] when state is 40',
            build: CounterCubit.new,
            seed: () => 40,
            act: (cubit) => cubit.decrement(),
            expect: () => const <int>[39],
          );
        },
      );
    },
  );
}

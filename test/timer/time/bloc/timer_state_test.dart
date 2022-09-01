import 'package:flutter_test/flutter_test.dart';

import '../../../../lib_timer/timer/bloc/timer_bloc.dart';

void main() {
  group('Timer State', () {
    group('Timer Initial', () {
      test('supports value comparison', () {
        expect(
          const TimerInitial(20),
          const TimerInitial(20),
        );
      });
    });

    group('TimerRunPaused', () {
      test('supports value comparison', () {
        expect(
          const TimerRunPause(60),
          const TimerRunPause(60),
        );
      });
    });
    group('Timer Initial', () {
      test('supports value comparison', () {
        expect(
          const TimerRunInProgress(20),
          const TimerRunInProgress(20),
        );
      });
    });
    group('Timer Initial', () {
      test('supports value comparison', () {
        expect(
          const TimerRunComplete(),
          const TimerRunComplete(),
        );
      });
    });
  });
}

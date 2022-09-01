import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../lib_timer/timer/bloc/timer_bloc.dart';
import '../../../../lib_timer/timer/view/timer_page.dart';

class MockTimerBloc extends MockBloc<TimerEvent, TimerState>
    implements TimerBloc {}

extension on WidgetTester {
  Future<void> pumpTimerView(TimerBloc timerBloc) async {
    return pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: timerBloc,
          child: const TimerView(),
        ),
      ),
    );
  }
}

void main() {
  late TimerBloc timerBloc;

  setUp(() {
    timerBloc = MockTimerBloc();
  });

  tearDown(() => reset(timerBloc));

  group('TimerPage', () {
    testWidgets('render TimerView', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: TimerPage()));
      expect(find.byType(TimerView), findsOneWidget);
    });
  });

  group('TimerView', () {
    testWidgets('render initial timer', (WidgetTester tester) async {
      when(() => timerBloc.state).thenReturn(const TimerInitial(60));
      await tester.pumpTimerView(timerBloc);
      expect(find.text('01:00'), findsOneWidget);
      expect(find.byIcon(Icons.play_arrow), findsOneWidget);
    });

    testWidgets('renders pause and reset button when timer is in progress',
        (WidgetTester tester) async {
      when(() => timerBloc.state).thenReturn(const TimerRunInProgress(58));
      await tester.pumpTimerView(timerBloc);
      expect(find.text('00:58'), findsOneWidget);
      expect(find.byIcon(Icons.pause), findsOneWidget);
      expect(find.byIcon(Icons.replay), findsOneWidget);
    });

    testWidgets('renders pause and reset button when timer is in paused',
        (WidgetTester tester) async {
      when(() => timerBloc.state).thenReturn(const TimerRunPause(40));
      await tester.pumpTimerView(timerBloc);
      expect(find.text('00:40'), findsOneWidget);
      expect(find.byIcon(Icons.play_arrow), findsOneWidget);
      expect(find.byIcon(Icons.replay), findsOneWidget);
    });

    testWidgets('renders replay icon when timer is complete',
        (WidgetTester tester) async {
      when(() => timerBloc.state).thenReturn(const TimerRunComplete());

      await tester.pumpTimerView(timerBloc);
      expect(find.text('00:00'), findsOneWidget);
      expect(find.byIcon(Icons.replay), findsOneWidget);
    });

    testWidgets('timer started when play arrow button is pressed',
        (WidgetTester tester) async {
      when(() => timerBloc.state).thenReturn(const TimerInitial(60));
      await tester.pumpTimerView(timerBloc);
      await tester.tap(find.byIcon(Icons.play_arrow));
      verify(() => timerBloc.add(const TimerStarted(duration: 60))).called(1);
    });

    testWidgets(
        'timer is paused when pause button is pressed'
        'while timer is still in progress', (WidgetTester tester) async {
      when(() => timerBloc.state).thenReturn(const TimerRunInProgress(56));
      await tester.pumpTimerView(timerBloc);
      await tester.tap(find.byIcon(Icons.pause));
      verify(() => timerBloc.add(const TimerPaused())).called(1);
    });

    testWidgets(
        'timer resets when replay button is pressed '
        'while timer is in progress', (WidgetTester tester) async {
      when(() => timerBloc.state).thenReturn(const TimerRunInProgress(24));
      await tester.pumpTimerView(timerBloc);
      await tester.tap(find.byIcon(Icons.replay));
      verify(() => timerBloc.add(const TimerReset())).called(1);
    });

    testWidgets(
        'timer resumes when play arrow button is pressed '
        'while timer is paused', (WidgetTester tester) async {
      when(() => timerBloc.state).thenReturn(const TimerRunPause(24));
      await tester.pumpTimerView(timerBloc);
      await tester.tap(find.byIcon(Icons.play_arrow));
      verify(() => timerBloc.add(const TimerResumed())).called(1);
    });

    testWidgets(
        'timer resets when reset button is pressed '
        'while timer is paused', (WidgetTester tester) async {
      when(() => timerBloc.state).thenReturn(const TimerRunPause(24));
      await tester.pumpTimerView(timerBloc);
      await tester.tap(find.byIcon(Icons.replay));
      verify(() => timerBloc.add(const TimerReset())).called(1);
    });

    testWidgets(
        'timer resets when reset button is pressed '
        'when timer is finished', (WidgetTester tester) async {
      when(() => timerBloc.state).thenReturn(const TimerRunComplete());
      await tester.pumpTimerView(timerBloc);
      await tester.tap(find.byIcon(Icons.replay));
      verify(() => timerBloc.add(const TimerReset())).called(1);
    });
  });
}

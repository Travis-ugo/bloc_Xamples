import 'package:flutter/material.dart';

import 'timer/view/timer_page.dart';

class MyAppTimer extends StatelessWidget {
  const MyAppTimer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const TimerPage(),
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(109, 234, 255, 1),
        colorScheme: const ColorScheme.light(
          secondary: Color.fromARGB(255, 141, 144, 235),
        ),
      ),
    );
  }
}

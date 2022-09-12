import 'package:firebase_flow/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/login_cubit.dart';
import 'login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  static Page<void> page() => const MaterialPage<void>(child: LoginPage());
  // static Route<void> route() {
  //   return MaterialPageRoute<void>(builder: (_) => const LoginPage());
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('log in'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: BlocProvider(
          child: const LoginForm(),
          create: (_) => LoginCubit(
            context.read<AuthenticationRepository>(),
          ),
        ),
      ),
    );
  }
}

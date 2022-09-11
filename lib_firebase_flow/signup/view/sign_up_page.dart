import 'package:firebase_flow/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/signup_cubit.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({Key? key}) : super(key: key);

  // static Page<void> page() => const MaterialPage<void>(child: SignupPage());
  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const SignupPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocProvider<SignupCubit>(
          child: const SignupPage(),
          create: (_) => SignupCubit(
            context.read<AuthenticationRepository>(),
          ),
        ),
      ),
    );
  }
}

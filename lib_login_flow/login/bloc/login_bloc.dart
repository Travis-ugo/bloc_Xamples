import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../models/models.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationRepository _authenticationRepository;
  LoginBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const LoginState()) {
    on<LoginUsernameChanged>(_onUsernameChanged);
    on<LoginPassWordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  void _onUsernameChanged(
    LoginUsernameChanged events,
    Emitter<LoginState> emits,
  ) {
    final username = Username.dirty(events.username);
    emits(
      state.copyWith(
        status: Formz.validate([state.password, username]),
        username: username,
      ),
    );
  }

  void _onPasswordChanged(
    LoginPassWordChanged events,
    Emitter<LoginState> emits,
  ) {
    final password = Password.dirty(events.password);
    emits(
      state.copyWith(
        status: Formz.validate([password, state.password]),
        password: password,
      ),
    );
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted events,
    Emitter<LoginState> emits,
  ) async {
    if (state.status.isValidated) {
      emits(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        await _authenticationRepository.login(
          username: state.username.value,
          password: state.password.value,
        );
        emits(state.copyWith(status: FormzStatus.submissionSuccess));
      } catch (_) {
        emits(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}

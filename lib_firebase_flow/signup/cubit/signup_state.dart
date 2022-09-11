// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'signup_cubit.dart';

enum ConfirmEmailValidationError { invalid }

class SignupState extends Equatable {
  const SignupState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
    this.confirmedPassword = const ConfirmedPassword.pure(),
    this.errorMessage,
  });

  final Email email;
  final Password password;
  final FormzStatus status;
  final String? errorMessage;
  final ConfirmedPassword confirmedPassword;

  @override
  List<Object> get props => [email, password, status, confirmedPassword];

  SignupState copyWith({
    Email? email,
    Password? password,
    FormzStatus? status,
    String? errorMessage,
    ConfirmedPassword? confirmedPassword,
  }) {
    return SignupState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      confirmedPassword: confirmedPassword ?? this.confirmedPassword,
    );
  }
}

import 'package:formz/formz.dart';

enum PassWordValidationError { empty }

class Password extends FormzInput<String, PassWordValidationError> {
  const Password.pure() : super.pure('');
  const Password.dirty([super.value = '']) : super.dirty();

  @override
  PassWordValidationError? validator(String value) {
    return value.isNotEmpty == true ? null : PassWordValidationError.empty;
  }
}

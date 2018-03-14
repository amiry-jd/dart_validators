part of dart_validators;

@Directive(
  selector: ''
      '[email][ngControl],'
      '[email][ngFormControl],'
      '[email][ngModel]',
  providers: const [
    const Provider(
      NG_VALIDATORS,
      useExisting: EmailValidator,
      multi: true,
    ),
  ],
)
class EmailValidator implements Validator {

  RegExp _regex;
  String _message;

  EmailValidator(@Attribute('email-pattern') String pattern,
      @Attribute('email-error-message') String message) {
    _regex =
        pattern == null ? _defaultEmailValidatorRegex : new RegExp(pattern);
    _message = message == null || message.isEmpty
        ? _defaultEmailValidationError
        : message;
  }

  @override
  Map<String, dynamic> validate(AbstractControl c) {
    final value = c.value.toString();
    if (value == null || value.isEmpty)
      return null;
    if (!_regex.hasMatch(value))
      return {
        'email': _message
      };
    return null;
  }
}

final RegExp _defaultEmailValidatorRegex = new RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
final String _defaultEmailValidationError = 'Email is invalid.';

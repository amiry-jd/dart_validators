part of dart_validators;

@Directive(
  selector: ''
      '[password][ngControl],'
      '[password][ngFormControl],'
      '[password][ngModel]',
  providers: const [
    const Provider(
      NG_VALIDATORS,
      useExisting: PasswordStrengthValidator,
      multi: true,
    ),
  ],
)
class PasswordStrengthValidator implements Validator {

  int _upperCaseCount;
  int _lowerCaseCount;
  int _numeralCount;
  int _nonWordCount;

  PasswordStrengthValidator(
    @Attribute('password-uppercase-count') String upperCaseCount,
    @Attribute('password-lowercase-count') String lowerCaseCount,
    @Attribute('password-numeral-count') String numeralCount,
    @Attribute('password-nonword-count') String nonWordCount,
  ) {
    if (upperCaseCount != null && upperCaseCount.isNotEmpty)
      _upperCaseCount = int.parse(upperCaseCount);
    if (lowerCaseCount != null && lowerCaseCount.isNotEmpty)
      _lowerCaseCount = int.parse(lowerCaseCount);
    if (numeralCount != null && numeralCount.isNotEmpty)
      _numeralCount = int.parse(numeralCount);
    if (nonWordCount != null && nonWordCount.isNotEmpty)
      _nonWordCount = int.parse(nonWordCount);
  }

  @override
  Map<String, dynamic> validate(AbstractControl c) {
    final value = c.value.toString();

    if (value == null || value.isEmpty) return null;

    if (_upperCaseCount != null && _upperCaseCount > 0) {
      var matchesCount = _upperCaseTester.allMatches(value);
      if (matchesCount.length < _upperCaseCount)
        return {
          'password': 'At least $_upperCaseCount uppercase letter required.'
        };
    }

    if (_lowerCaseCount != null && _lowerCaseCount > 0) {
      var matchesCount = _lowerCaseTester.allMatches(value);
      if (matchesCount.length < _lowerCaseCount)
        return {
          'password': 'At least $_lowerCaseCount lowercase letter required.'
        };
    }

    if (_numeralCount != null && _numeralCount > 0) {
      var matchesCount = _numeralTester.allMatches(value);
      if (matchesCount.length < _numeralCount)
        return {
          'password': 'At least $_numeralCount numeral character required.'
        };
    }

    if (_nonWordCount != null && _nonWordCount > 0) {
      var matchesCount = _nonWordTester.allMatches(value);
      if (matchesCount.length < _nonWordCount)
        return {
          'password': 'At least $_nonWordCount numeral character required.'
        };
    }

    return null;
  }
}

final RegExp _upperCaseTester = new RegExp(r'[A-Z]');
final RegExp _lowerCaseTester = new RegExp(r'[a-z]');
final RegExp _numeralTester = new RegExp(r'\d');
final RegExp _nonWordTester = new RegExp(r'\W');
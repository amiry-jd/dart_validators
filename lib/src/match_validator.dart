part of dart_validators;

@Directive(
  selector: ''
      '[should-match][ngControl],'
      '[should-match][ngFormControl],'
      '[should-match][ngModel]',
  providers: const [
    const Provider(
      NG_VALIDATORS,
      useExisting: MatchValidator,
      multi: true,
    ),
  ],
)
class MatchValidator implements Validator {
  @HostBinding('attr.should-match')
  String matchAttr;
  NgControl _match;
  AbstractControl _cache;
  String _message = 'The value sould match to source.';

  NgControl get match => _match;

  @Input('should-match')
  set match(NgControl value) {
    _match = value;
    matchAttr = value.toString();
    _match.control.valueChanges.listen((event) {
      if (_cache != null) _cache.updateValueAndValidity();
    });
  }

  MatchValidator(@Attribute('should-match-error-message') String message) {
    if (message != null) _message = message;
  }

  @override
  Map<String, dynamic> validate(AbstractControl c) {
    _cache = c;
    final sourceValue = _match.value.toString();
    final value = c.value.toString();
    if (value != sourceValue) return {'match': _message};
    return null;
  }
}

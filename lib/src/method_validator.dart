part of dart_validators;

@Directive(
  selector: ''
      '[validator-method][ngControl],'
      '[validator-method][ngFormControl],'
      '[validator-method][ngModel]',
  providers: const [
    const Provider(
      NG_VALIDATORS,
      useExisting: MethodValidator,
      multi: true,
    ),
  ],
)
class MethodValidator implements Validator {
  @HostBinding('attr.validator-method')
  String methodAttr;
  ValidatorFn _method;

  ValidatorFn get method => _method;

  @Input('validator-method')
  set match(ValidatorFn value) {
    _method = value;
    methodAttr = value.toString();
  }

  @override
  Map<String, dynamic> validate(AbstractControl c) {if(_method!=null) return _method(c);return null;}
}

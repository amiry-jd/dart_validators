library dart_validators;

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

part 'src/email_validator.dart';
part 'src/password_strength_validator.dart';
part 'src/match_validator.dart';
part 'src/method_validator.dart';

const List<Type> VALIDATORS_DIRECTIVES = const [
  EmailValidator,
  PasswordStrengthValidator,
  MatchValidator,
  MethodValidator,
];
# dart_validators

A useful set of validators for using in an [AngularDart][AngularDart] web application.

## Usage

Having a component named `RegisterComponent`, you can use these
validators as simple as these snippets:

Code-behind file:

    // register_component.dart

    import 'package:angular/angular.dart';
    import 'package:angular_forms/angular_forms.dart';
    import 'package:dart_validators/dart_validators.dart';

    @Component(
      selector: 'register',
      templateUrl: 'register_component.html',
      directives: const [
        CORE_DIRECTIVES,
        ROUTER_DIRECTIVES,
        formDirectives,
        VALIDATORS_DIRECTIVES, // dont forgot to import validators directives
      ],
    )
    class RegisterComponent {
        // all code-behind codes go here...
    }

HTML file:

    <!-- register_component.html -->
    <form #loginForm="ngForm">
        <!-- all HTML snippets go here... -->
    </form>

#### Using `EmailValidator`

Using EmailValidator basically doesn't need any code-behind and
all can be done in HTML bu just adding an `email` attribute to an
`input` tag -except custom error messages which we will
discuss later in this document:

    <input type="email" required email />

This will evaluate the input as an email address. But it will not check
being `required`. To do that, you still need use the `required` attribute.

#### Using `PasswordStrengthValidator`

The `PasswordStrengthValidator` checks if a password input is strength
enough or not. To use `PasswordStrengthValidator` you just need to add
a `password` attribute to element:

    <input type="password" required password minlength="8" />

Still, it wouldn't check for being required and you have to add
`required` to check that. Also, since there was a built-in `minlength`
validator, The `PasswordStrengthValidator` wouldn't check for this too
and you have to use the built-in validator.

To get `PasswordStrengthValidator` to work, you need to set at least
one of these configurable attributes to a non-zero value:

- `password-uppercase-count`: the minimum count of uppercase letters needed to pass the check
- `password-lowercase-count`: the minimum count of lowercase letters needed to pass the check
- `password-numeral-count`: the minimum count of numeric characters needed to pass the check
- `password-nonword-count`: the minimum count of non-word characters needed to pass the check

#### Using `MatchValidator`

The `MatchValidator` validates an input value against a certain element's
value to be exactly same. Usually it's useful to validate a `confirm-password`'s
value to be matched with the `password`'s value. To use this validator,
you need to 1. identify the source element, 2. put the `[should-match]`
bindable attribute on target element, 3. and pass the source element's
identifier to `[should-match]` attribute on target element:

    <!-- identify the source element -->
    <input type="password" name="password" #passwordField />

    <!-- put attribute and pass identifier to target element -->
    <input type="password" name="confirm_password" [should-match]="passwordField" />

#### Using `MethodValidator`

Sometimes you need to validate an input value in code-behind. For example
checking a username or email availability which needs to call and get
result from an API. To do that, you can create a dart method and bind
your element's validation flow to it:

    // register_component.dart
    Map<String, dynamic> validateUsername(AbstractControl c) {
        var u = c.value.toString();
        // do the validation here. For example call an API
        // or whatever you need to validate value:
        if (u == 'javad_amiry')
            return {'username': 'Userame is taken.'};
        return null;
    }

And in HTML pass the method's name to bindable `[validator-method]` attribute:

    <!-- register_component.html -->
    <input type="text" [validator-method]="validateUsername" />

The validator method, returns `null` if validation check passed, and
a `Map<String, String>` in case there is an error -which you can see
in above example.

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[AngularDart]: https://webdev.dartlang.org/angular
[tracker]: https://github.com/javad-amiry/dart_validators/issues
[git]: https://github.com/javad-amiry/dart_validators

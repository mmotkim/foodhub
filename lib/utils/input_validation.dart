import 'package:reactive_forms/reactive_forms.dart';

class InputValidation {
  static FormControl<String> password = FormControl<String>(
    validators: [
      Validators.required,
      Validators.minLength(6),
    ],
  );

  static FormControl<String> email = FormControl<String>(
    validators: [
      Validators.required,
      Validators.email,
    ],
  );

  static FormControl<String> name = FormControl<String>(
    validators: [
      Validators.required,
    ],
  );
}

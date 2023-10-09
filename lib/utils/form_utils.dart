import 'package:reactive_forms/reactive_forms.dart';

class FormUtils {
  static void disposeAll(FormGroup form) {
    form.controls.forEach((key, value) {
      value.updateValue('');
      value.markAsUntouched();
    });
  }
}

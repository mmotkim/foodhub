import 'package:easy_localization/easy_localization.dart';
import 'package:foodhub/gen/locale_keys.g.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_phone_form_field/reactive_phone_form_field.dart';

class InputValidation {
  static FormControl<String> password = FormControl<String>(
    validators: [
      Validators.required,
      Validators.minLength(6),
      Validators.maxLength(16),
      Validators.pattern(r'^(?=.*[0-9]).+$',
          validationMessage: LocaleKeys.passwordOneNumber),
      Validators.pattern(r'^(?=.*[A-Z]).+$',
          validationMessage: LocaleKeys.passwordOneUppercase),
      Validators.pattern(r'^(?=.*[a-z]).+$',
          validationMessage: LocaleKeys.passwordOneUppercase),
      Validators.pattern(r'^(?=.*[^a-zA-Z0-9]).+$',
          validationMessage:
              // r'Please include at least one special character (e.g., @, #, $) in your password'),
              LocaleKeys.passwordOneSpecialCharacter),
      Validators.pattern(r'^\S+$',
          // validationMessage: 'Password should not contain any space character')
          validationMessage: LocaleKeys.passwordContainsSpace),
    ],
  );
  static FormControl<String> passwordLogin = FormControl<String>(
    validators: [
      Validators.required,
      Validators.pattern(r'^\S+$',
          validationMessage: 'Password should not contain any space character')
    ],
  );

  static FormControl<String> email = FormControl<String>(
    validators: [
      Validators.required,
    ],
    value: '',
  );

  static FormControl<String> name = FormControl<String>(
    validators: [
      Validators.required,
    ],
  );

  static FormControl<PhoneNumber> phone = FormControl<PhoneNumber>(
    validators: [
      Validators.required,
      // Validators.pattern(
      //   r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$',
      //   validationMessage: LocaleKeys.phoneWrongFormat,
      // ),
    ],
  );

  static Map<String, String Function(Object)> passwordSignUpMap = {
    LocaleKeys.required: (error) => LocaleKeys.required.tr(),
    LocaleKeys.passwordContainsSpace: (error) =>
        LocaleKeys.passwordContainsSpace.tr(),
    LocaleKeys.passwordOneLowercase: (error) =>
        LocaleKeys.passwordOneLowercase.tr(),
    LocaleKeys.passwordOneNumber: (error) => LocaleKeys.passwordOneNumber.tr(),
    LocaleKeys.passwordOneSpecialCharacter: (error) =>
        LocaleKeys.passwordOneSpecialCharacter.tr(),
    LocaleKeys.passwordOneUppercase: (error) =>
        LocaleKeys.passwordOneUppercase.tr(),
    LocaleKeys.maxLength: (error) => LocaleKeys.maxLength.tr(),
    LocaleKeys.minLength: (error) => LocaleKeys.minLength.tr(),
  };

  static Map<String, String Function(Object)> passwordSignInMap = {
    LocaleKeys.required: (error) => LocaleKeys.required.tr(),
    LocaleKeys.passwordContainsSpace: (error) =>
        LocaleKeys.passwordContainsSpace.tr(),
  };

  static Map<String, String Function(Object)> emailMap = {
    LocaleKeys.required: (error) => LocaleKeys.required.tr(),
    LocaleKeys.email: (error) => LocaleKeys.emailWrongFormat.tr(),
  };

  static Map<String, String Function(Object)> nameMap = {
    LocaleKeys.required: (error) => LocaleKeys.required.tr(),
  };

  static Map<String, String Function(Object)> phoneMap = {
    LocaleKeys.required: (error) => LocaleKeys.required.tr(),
    LocaleKeys.phoneWrongFormat: (error) => LocaleKeys.phoneWrongFormat.tr(),
  };
}

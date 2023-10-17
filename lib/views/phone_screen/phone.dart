import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:foodhub/auth/controllers/auth_controller.dart';
import 'package:foodhub/components/form_submit_button.dart';
import 'package:foodhub/gen/assets.gen.dart';
import 'package:foodhub/gen/locale_keys.g.dart';
import 'package:foodhub/routes/app_router.gr.dart';
import 'package:foodhub/styles/custom_colors.dart';
import 'package:foodhub/styles/custom_texts.dart';
import 'package:foodhub/utils/input_validation.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_phone_form_field/reactive_phone_form_field.dart';

@RoutePage()
class PhoneScreen extends StatefulWidget {
  const PhoneScreen({super.key});

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  final phoneController = TextEditingController();
  final form = FormGroup({'phone': InputValidation.phone});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: ReactiveForm(
            formGroup: form,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _phoneContent(context)),
          ),
        ),
      ),
    );
  }

  List<Widget> _phoneContent(BuildContext context) {
    return <Widget>[
      Container(
        height: 80,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Assets.topDeco.provider(),
            fit: BoxFit.cover,
          ),
        ),
      ),
      const SizedBox(height: 68.0),

      // Sign Up Heading Title
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocaleKeys.phoneRegistration.tr(),
              style: CustomTextStyle.headlineLarge(context),
            ),
            const SizedBox(height: 14),
            SizedBox(
              width: 230,
              child: Text(
                LocaleKeys.phoneRegistrationBody.tr(),
                style: CustomTextStyle.bodySmall(context),
              ),
            ),
            const SizedBox(height: 38),
            Container(
                decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    shadows: const [
                      CustomColors.fieldShadow,
                    ]),
                child: const PhoneField()),
            const SizedBox(height: 51),
            Center(
              child: FormSubmitButton(
                text: 'signUp'.tr().toUpperCase(),
                onPressed: _handleSubmit,
              ),
            ),
          ],
        ),
        // child: Text(LocaleKeys.signIn.tr()),
      ),
    ];
  }

  Future<void> _handleSubmit() async {

    AuthController authController =
        Provider.of<AuthController>(context, listen: false);

    try {
      final phoneNumberObj =
          form.value.values.firstWhereOrNull((element) => true) as PhoneNumber;

      final phoneNumber = '+${phoneNumberObj.countryCode}${phoneNumberObj.nsn}';
      context.router.push(const VerificationRoute());

      await authController.signInWithPhone(context, phoneNumber);
    } catch (e) {
      rethrow;
    }
  }
}

class PhoneField extends StatelessWidget {
  const PhoneField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ReactivePhoneFormField<PhoneNumber>(
      formControlName: 'phone',
      defaultCountry: IsoCode.VN,
      flagSize: 18,
      countryCodeStyle: CustomTextStyle.fieldText,
      strutStyle: StrutStyle.fromTextStyle(CustomTextStyle.fieldText),
      style: CustomTextStyle.fieldText,
      decoration: inputDeco(),
    );
  }

  InputDecoration inputDeco() {
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: Colors.grey.shade200,
          width: 1.5,
        ),
      ),
      contentPadding: const EdgeInsets.all(20),
      focusColor: CustomColors.primary,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: CustomColors.primary,
          width: 1.5,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Color(0xFFFF0000),
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Color(0x197F7F7F),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: Colors.grey.shade200,
          width: 1.5,
        ),
      ),
    );
  }
}

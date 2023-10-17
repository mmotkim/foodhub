import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodhub/gen/assets.gen.dart';
import 'package:foodhub/gen/locale_keys.g.dart';
import 'package:foodhub/styles/custom_texts.dart';
import 'package:foodhub/utils/app_state.dart';
import 'package:provider/provider.dart';

import 'codeInput_form.dart';

@RoutePage()
class VerifyCodeScreen extends StatelessWidget {
  const VerifyCodeScreen({super.key, required this.email, required this.isLoggedIn});
  final String email;
  final bool isLoggedIn;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              const TopDeco(),
              SizedBox(
                height: size.height,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 26),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: _verificationContent(context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _verificationContent(BuildContext context) {
    return <Widget>[
      //heading
      Text(
        LocaleKeys.verificationCode.tr(),
        style: CustomTextStyle.headlineLarge(context),
      ),
      const SizedBox(height: 12),
      //body
      Text(
        '${LocaleKeys.authVerificationBody.tr()} $email',
        style: CustomTextStyle.bodySmall(context),
      ),
      const SizedBox(height: 16),

      CodeInputForm(email: email, isLoggedIn: isLoggedIn),

      const SizedBox(height: 300),
    ];
  }
}

class TopDeco extends StatelessWidget {
  const TopDeco({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80, // Adjust the height as needed
      decoration: BoxDecoration(
        image: DecorationImage(
          image: Assets.topDeco.provider(),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

// class CodeInput extends StatelessWidget {
//   const CodeInput({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 65,
//       height: 65,
//       decoration: ShapeDecoration(
//         color: Colors.white,
//         shape: RoundedRectangleBorder(
//           side: const BorderSide(width: 1, color: Color(0xFFEEEEEE)),
//           borderRadius: BorderRadius.circular(10),
//         ),
//         shadows: const [
//           BoxShadow(
//             color: Color(0x3FE8E8E8),
//             blurRadius: 45,
//             offset: Offset(15, 20),
//             spreadRadius: 0,
//           )
//         ],
//       ),
//       child: ReactiveTextField(
//         keyboardType: TextInputType.number,
//         decoration: const InputDecoration(hintText: "0"),
//         style: CustomTextStyle.pinCode,
//         textAlign: TextAlign.center,
//         inputFormatters: [
//           LengthLimitingTextInputFormatter(1),
//           FilteringTextInputFormatter.digitsOnly
//         ],
//       ),
//     );
//   }
// }

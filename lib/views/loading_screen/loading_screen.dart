import 'package:flutter/material.dart';
import 'package:foodhub/auth/controllers/auth_controller.dart';
import 'package:foodhub/gen/locale_keys.g.dart';
import 'package:foodhub/views/verification/verification.dart';
import 'package:foodhub/styles/custom_texts.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatefulWidget {
  final String loadingMessage;
  final String loadedMessage;
  const LoadingScreen(
      {super.key, required this.loadingMessage, required this.loadedMessage});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool completed = false;

  @override
  void initState() {
    super.initState();
    // Simulate a 2-second delay to show the loading indicator
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        completed = true;
      });
      final authProvider = Provider.of<AuthController>(context, listen: false);

      if (completed && authProvider.errorMessage == null) {
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const VerificationScreen(),
            ),
            (Route<dynamic> route) => false,
          );
        });
      } else if (completed && authProvider.errorMessage != null) {
        Future.delayed(const Duration(milliseconds: 1500), () {
          Navigator.pop(context);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthController>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            completed
                ? authProvider.errorMessage != null
                    ? const Icon(
                        Icons.close,
                        color: Colors.red,
                        size: 50.0,
                      )
                    : const Icon(
                        Icons.check,
                        color: Colors.green,
                        size: 50.0,
                      )
                : Column(
                    children: [
                      const CircularProgressIndicator(color: Color(0xFFFE724C)),
                      const SizedBox(height: 20),
                      Text(
                        widget.loadingMessage,
                        style: CustomTextStyle.labellarge(context)
                            .copyWith(color: const Color(0xFFFE724C)),
                      ),
                    ],
                  ),
            if (completed)
              authProvider.errorMessage != null
                  ? Column(
                      children: [
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 26),
                          child: Text(
                            authProvider.errorMessage!,
                            textAlign: TextAlign.center,
                            style: CustomTextStyle.labellarge(context)
                                .copyWith(color: Colors.red),
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    )
                  : Column(
                      children: [
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 26),
                          child: Text(
                            // 'Account creation complete!',
                            widget.loadedMessage,
                            textAlign: TextAlign.center,
                            style: CustomTextStyle.labellarge(context)
                                .copyWith(color: Colors.green),
                          ),
                        ),
                        // PrimaryButton(
                        //   text: 'CONTINUE',
                        //   onPressed: () {
                        //     Navigator.pushReplacement(
                        //         context,
                        //         MaterialPageRoute(
                        //           builder: (context) =>
                        //               const VerificationScreen(),
                        //         ));
                        //   },
                        // ),
                      ],
                    ),
          ],
        ),
      ),
    );
  }
}

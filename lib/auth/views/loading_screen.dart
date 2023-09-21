import 'package:flutter/material.dart';
import 'package:foodhub/auth/controllers/auth_controller.dart';
import 'package:foodhub/auth/views/verification.dart';
import 'package:foodhub/components/primary_button.dart';
import 'package:foodhub/components/secondary_button.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

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
                        size: 64.0,
                      )
                    : const Icon(
                        Icons.check,
                        color: Colors.green,
                        size: 64.0,
                      )
                : const Column(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 10),
                      Text('Setting up your account'),
                    ],
                  ),
            const SizedBox(height: 15),
            if (completed)
              authProvider.errorMessage != null
                  ? Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 26),
                          child: Text(
                            authProvider.errorMessage!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                        const SizedBox(height: 30),
                        SecondaryButton(
                            text: 'GO BACK',
                            onPressed: () {
                              Navigator.pop(context);
                            })
                      ],
                    )
                  : PrimaryButton(
                      text: 'CONTINUE',
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const VerificationScreen(),
                            ));
                      },
                    )
          ],
        ),
      ),
    );
  }
}

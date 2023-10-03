import 'package:flutter/material.dart';
import 'package:foodhub/auth/controllers/auth_controller.dart';
import 'package:foodhub/styles/animated_routes.dart';
import 'package:foodhub/styles/custom_texts.dart';
import 'package:foodhub/views/welcome/welcome.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
              SizedBox(
                height: size.height,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 26),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: _homeContent(context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _homeContent(BuildContext context) {
    AuthController authController =
        Provider.of<AuthController>(context, listen: false);
    return <Widget>[
      const UserInfo(),
      TextButton(
        onPressed: () {
          authController.signOut();
          Navigator.push(
              context, AnimatedRoutes.slideRight(const WelcomeScreen()));
        },
        child: const Text('Sign the fuck out'),
      ),
    ];
  }
}

class UserInfo extends StatelessWidget {
  const UserInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      /// Calls `context.watch` to make [Count] rebuild when [Counter] changes.
      'name ${context.watch<AuthController>().getCurrentUser()?.displayName}\n'
      'email ${context.watch<AuthController>().getCurrentUser()?.email}\n'
      'phone ${context.watch<AuthController>().getCurrentUser()?.phoneNumber}\n'
      'mailVerified ${context.watch<AuthController>().getCurrentUser()?.emailVerified}\n'
      'uid ${context.watch<AuthController>().getCurrentUser()?.uid}\n',
      key: const Key('counterState'),
      style: CustomTextStyle.fieldText,
    );
  }
}

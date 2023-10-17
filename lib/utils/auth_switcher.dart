import 'package:flutter/material.dart';
import 'package:foodhub/utils/app_state.dart';
import 'package:provider/provider.dart';

class AuthSwitcher extends StatefulWidget {
  const AuthSwitcher({super.key});

  @override
  State<AuthSwitcher> createState() => _AuthSwitcherState();
}

class _AuthSwitcherState extends State<AuthSwitcher> {
  bool value = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: Provider.of<ApplicationState>(context).useFirebaseAuth,
      onChanged: (value) => context.read<ApplicationState>().switchAuth(value),
    );
  }
}

import 'package:flutter/material.dart';

class MainMemu extends StatefulWidget {
  const MainMemu({super.key});

  @override
  State<MainMemu> createState() => _MainMemuState();
}

class _MainMemuState extends State<MainMemu> {
  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    return Scaffold(
      body: Text("${arguments['email']} \n ${arguments['password']}"),
    );
  }
}

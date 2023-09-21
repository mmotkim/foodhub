import 'package:flutter/material.dart';

class SecondaryButton extends StatefulWidget {
  const SecondaryButton({
    super.key,
    required this.text,
    required this.onPressed,
  });
  final String text;
  final GestureTapCallback onPressed;

  @override
  State<SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<SecondaryButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 248,
      height: 60,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: const Color(0xFFFE724C), width: 1.7),
        boxShadow: const [
          // BoxShadow(
          //   color: Color.fromARGB(64, 81, 81, 81),
          //   blurRadius: 10,
          //   offset: Offset(0, 8),
          //   spreadRadius: 0,
          // ),
        ],
      ),
      child: TextButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          surfaceTintColor: Colors.transparent,
          backgroundColor:
              Colors.transparent, // Make the ElevatedButton transparent
          shadowColor: Colors.transparent, // Remove shadow
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.text,
              style: const TextStyle(
                color: Color(0xFFFE724C),
                fontSize: 15,
                fontWeight: FontWeight.w600,
                fontFamily: 'SofiaPro',
                letterSpacing: 1.20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

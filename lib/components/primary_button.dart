import 'package:flutter/material.dart';

class PrimaryButton extends StatefulWidget {
  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
  });
  final String text;
  final GestureTapCallback onPressed;

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 248,
      height: 60,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: const Color(0xFFFE724C),
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(
            color: Color(0x40FE724C),
            blurRadius: 30,
            offset: Offset(0, 8),
            spreadRadius: 0,
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              Colors.transparent, // Make the ElevatedButton transparent
          shadowColor: Colors.transparent, // Remove shadow
        ),
        child: Text(
          widget.text,
          style: const TextStyle(
            color: Color(0xFFFEFEFE),
            fontSize: 15,
            fontWeight: FontWeight.w600,
            fontFamily: 'SofiaPro',
            letterSpacing: 1.20,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CustomColors {
  static const Color primary = Color(0xFFFE724C);

  static const Color lightPrimary = Color(0xFFFFEBE6);

  static const Color label = Color(0xFF9796A1);

  static const Color fieldBorder = Color(0xFFEEEEEE);

  static const Color cursor = Color(0xFFFFC529);

  static const BoxShadow fieldShadow = BoxShadow(
    color: Color(0x3ED3D1D8),
    blurRadius: 30,
    offset: Offset(15, 15),
    spreadRadius: 0,
  );

  static BoxShadow pinFieldShadow = BoxShadow(
    color: const Color(0x3FE8E8E8).withOpacity(0.5),
    blurRadius: 45,
    offset: const Offset(15, 20),
    spreadRadius: 0,
  );
}

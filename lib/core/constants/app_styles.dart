import 'package:flutter/material.dart';

class AppStyles {
  // Main Heading Style
  static const TextStyle mainHeading = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: Color(0xFF222222),
    letterSpacing: 1.2,
  );

  // Subtitle Style
  static const TextStyle subTitle = TextStyle(
    fontSize: 14,
    color: Colors.grey,
    fontWeight: FontWeight.w400,
  );

  // Field Input Border Decoration (Reusable for all TextFields)
  static InputDecoration inputDecoration({
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.grey),
      ),
    );
  }
}

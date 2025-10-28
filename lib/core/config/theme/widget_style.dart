import 'package:flutter/material.dart';
import 'package:kasir_app/core/config/theme/color_style.dart';

class WidgetStyle {
  WidgetStyle._();

  static InputDecoration textfieldDecoration({
    String? hintText,
    String? helperText,
  }) {
    return InputDecoration(
      filled: true,
      fillColor: ColorStyle.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: ColorStyle.grey, width: 1),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorStyle.grey, width: 1),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorStyle.primaryBlue, width: 2),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      hintText: hintText,
      helperText: helperText,
      hintStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: ColorStyle.grey,
      ),
    );
  }

  static InputDecoration dropdownButtonDecoration({
    String? hintText,
    String? helperText,
  }) {
    return InputDecoration(
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: ColorStyle.primaryBlue, width: 1),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      filled: true,
      fillColor: ColorStyle.white,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorStyle.primaryBlue, width: 1),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorStyle.primaryBlue, width: 2),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      hintText: hintText,
      helperText: helperText,
      hintStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: ColorStyle.grey,
      ),
    );
  }

  static InputDecoration searchFieldDecoration({
    required Widget prefixIcon,
    String? hintText,
    String? helperText,
  }) {
    return InputDecoration(
      prefixIcon: Padding(
        padding: const EdgeInsets.only(left: 4),
        child: prefixIcon,
      ),
      filled: true,
      fillColor: ColorStyle.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: ColorStyle.grey, width: 1),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorStyle.grey, width: 1),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorStyle.primaryBlue, width: 2),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      hintText: hintText,
      helperText: helperText,
      hintStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: ColorStyle.grey,
      ),
    );
  }

  static ButtonStyle filledButtonStyle() {
    return FilledButton.styleFrom(
      foregroundColor: ColorStyle.white,
      backgroundColor: ColorStyle.primaryBlue,
      minimumSize: const Size.fromHeight(56),
      textStyle: const TextStyle(fontSize: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    );
  }

  static ButtonStyle outlinedButtonStyle() {
    return OutlinedButton.styleFrom(
      foregroundColor: ColorStyle.primaryBlue,
      side: BorderSide(color: ColorStyle.primaryBlue, width: 2),
      minimumSize: const Size.fromHeight(56),
      textStyle: const TextStyle(fontSize: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    );
  }
}

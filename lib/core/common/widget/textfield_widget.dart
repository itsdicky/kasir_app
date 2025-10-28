import 'package:flutter/material.dart';
import 'package:kasir_app/core/config/theme/widget_style.dart';

class TextfieldWidget extends StatelessWidget {
  const TextfieldWidget({
    super.key,
    required this.title,
    required this.hintText,
    this.helperText,
    this.controller,
    this.keyboardType,
    this.obsecureText = false,
    this.isRequired = false,
    this.validator,
  });

  final String title;
  final String hintText;
  final String? helperText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obsecureText;
  final bool isRequired;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 112,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obsecureText,
            style: Theme.of(context).textTheme.labelLarge,
            decoration: WidgetStyle.textfieldDecoration(
              hintText: hintText,
              helperText: helperText,
            ),
            validator: (value) {
              if (isRequired) {
                if (value == null || value.isEmpty) {
                  return 'Masukan ${title.toLowerCase()}';
                }
              }
              if (validator != null) {
                validator!(value);
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}





import 'package:flutter/material.dart';

class InputComponent extends StatelessWidget {
  final String label;
  final String hint;
  final IconData icon;
  final TextInputType? keyboard;
  final int maxRows;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;

  const InputComponent({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    required this.validator,
    required this.onChanged,
    this.keyboard = TextInputType.text,
    this.maxRows = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboard,
      maxLines: maxRows,
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(),
      ),
    );
  }
}
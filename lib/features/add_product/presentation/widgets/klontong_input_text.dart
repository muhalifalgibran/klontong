import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class KlontongInputTextWidget extends StatelessWidget {
  const KlontongInputTextWidget({
    required this.label,
    required this.hint,
    this.inputFormatters,
    this.keyboardType,
    this.maxLines = 1,
    this.onChanged,
    this.controller,
    this.validator,
    this.obscure = false,
    super.key,
  });

  final String label;
  final String hint;
  final bool obscure;
  final int maxLines;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12.0,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white70,
            border: Border.all(),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.12),
                blurRadius: 2,
                offset: const Offset(0, 2),
              )
            ],
          ),
          child: TextFormField(
            maxLines: maxLines,
            obscureText: obscure,
            controller: controller,
            validator: validator,
            style: const TextStyle(fontSize: 14.0),
            inputFormatters: inputFormatters,
            keyboardType: keyboardType,
            decoration: InputDecoration.collapsed(
              hintText: hint,
            ),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType? type;
  final int? length;
  final Function(String?)? onChange;
  final String? errorText;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.label,
    this.type,
    this.length,
    this.onChange,
    this.errorText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextField(
        controller: controller,
        maxLines: null,
        keyboardType: type,
        maxLength: length,
        onChanged: onChange,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          errorText: errorText,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
              width: 0.5,
            ),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
              width: 0.5,
            ),
          ),
          labelText: label,
          border: InputBorder.none,
          floatingLabelStyle: const TextStyle(
            fontSize: 18.0,
            color: Colors.grey,
          ),
          alignLabelWithHint: true,
          labelStyle: const TextStyle(
            color: Colors.black26,
          ),
        ),
      ),
    );
  }
}

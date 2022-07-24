import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType? type;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.label, this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextField(
        controller: controller,
        maxLines: null,
        keyboardType: type,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
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

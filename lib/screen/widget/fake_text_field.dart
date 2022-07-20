import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

class FakeTextField extends StatelessWidget {
  final bool haveValue;
  final VoidCallback onTap;
  final String value;

  const FakeTextField({
    Key? key,
    required this.haveValue,
    required this.onTap,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.maxFinite,
        margin: const EdgeInsets.symmetric(
          horizontal: 8,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          value,
          style: TextStyle(color: haveValue ? null : Colors.black26),
        ),
      ),
    );
  }
}

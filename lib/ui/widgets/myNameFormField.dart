import 'package:flutter/material.dart';

class MyNameFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;

  MyNameFormField({this.controller,@required this.label});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller?? "",
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter name';
        }
        return null;
      },
    );
  }
}

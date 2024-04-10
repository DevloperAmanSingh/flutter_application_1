import 'package:flutter/material.dart';

class FormTextField extends StatelessWidget {
  const FormTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 241, 239, 239),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 7,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: TextFormField(
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(10),
          hintText: 'Email',
          border: InputBorder.none,
        ),
      ),
    );
  }
}

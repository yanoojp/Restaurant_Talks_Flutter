import 'package:flutter/material.dart';

class FormWithLabelForLogin extends StatelessWidget {
  const FormWithLabelForLogin({super.key, required this.labelText,});
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          child: Text(
            labelText,
            textAlign: TextAlign.left,
          ),
        ),
        const TextField(),
      ],
    );
  }
}

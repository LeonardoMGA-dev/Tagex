import 'package:flutter/material.dart';

class Tag extends StatelessWidget {
  final String text;

  const Tag({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.blue),
      ),
      child: Text(text, style: const TextStyle(color: Colors.blue)),
    );
  }
}

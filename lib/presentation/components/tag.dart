import 'package:flutter/material.dart';

class Tag extends StatelessWidget {
  final String text;
  final void Function(String name)? onTap;
  final bool isSuggestion;
  final void Function(String name)? onLongPress;

  const Tag({
    Key? key,
    required this.text,
    this.onTap,
    this.isSuggestion = false,
    this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = isSuggestion ? Colors.green : Theme.of(context).colorScheme.secondary;
    return GestureDetector(
        onLongPress: () {
          if (onLongPress != null) {
            onLongPress!(text);
          }
        },
        onTap: () {
          if (onTap != null) {
            onTap!(text);
          }
        },
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: color),
          ),
          child: Text(text, style: TextStyle(color: color)),
        ));
  }
}

class TagModel {
  final String name;
  final bool isSuggestion;

  // override hashCode and == for comparison
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TagModel && other.name == name;
  }

  TagModel({required this.name, this.isSuggestion = false});

  @override
  int get hashCode => name.hashCode;

}

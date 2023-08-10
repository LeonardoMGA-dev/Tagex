import 'package:flutter/material.dart';
import 'package:tagex/presentation/components/tag.dart';

class Expense extends StatelessWidget {
  final String title;
  final String date;
  final double amount;
  final List<String> tags;

  const Expense({
    Key? key,
    required this.title,
    required this.date,
    required this.amount,
    required this.tags,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(date),
              const Expanded(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Divider(),
              )),
              Text("\$$amount"),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Wrap(
            spacing: 5,
            runSpacing: 5,
            children: tags.map((e) => Tag(text: e)).toList(),
          ),
        ],
      ),
    );
  }
}

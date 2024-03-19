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
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
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
              // convert date to human readable format only show hour and minute
              Text(date.split(" ").last.split(":").first +
                  ":" +
                  date.split(" ").last.split(":").last.substring(0, 2)),
              const Expanded(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
              )),
              Text("\$$amount",
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold)),
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

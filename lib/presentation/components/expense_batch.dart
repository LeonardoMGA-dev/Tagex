import 'package:flutter/material.dart';
import 'package:tagex/presentation/components/expense.dart';

class ExpenseBatch extends StatelessWidget {
  final List<ExpenseModel> expenses;

  const ExpenseBatch({Key? key, required this.expenses}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // convert date to human readable format e.g Monday, 12th July 2021
    final date = expenses.first.date.toString().split(" ").first;
    // get total amount
    final totalAmount = expenses.fold(
        0.0, (previousValue, element) => previousValue + element.amount);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    // convert date to human readable format
                    date,
                  ),
                  const Spacer(),
                  Text(
                    "Total: \$${totalAmount.toStringAsFixed(2)}",
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                children: _buildExpenseList(expenses),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildExpenseList(List<ExpenseModel> expenses) {
    return expenses
        .map((e) => Expense(
              title: e.title,
              date: e.date.toString(),
              amount: e.amount,
              tags: e.tags,
            ))
        .toList();
  }
}

class ExpenseModel {
  final String title;
  final DateTime date;
  final double amount;
  final List<String> tags;

  ExpenseModel({
    required this.title,
    required this.date,
    required this.amount,
    required this.tags,
  });
}

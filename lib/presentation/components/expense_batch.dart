import 'package:flutter/material.dart';
import 'package:tagex/domain/expense/model/expense_model.dart';
import 'package:tagex/presentation/components/expense.dart';

class ExpenseBatch extends StatelessWidget {
  final List<ExpenseModel> expenses;

  const ExpenseBatch({Key? key, required this.expenses}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Row(
            children: [
              Text(
                "Monday, 1st March 2021",
              ),
              Spacer(),
              Text(
                "\$1000",
              ),
            ],
          ),
          const Divider(),
          Column(
            children: _buildExpenseList(expenses),
          ),
        ],
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

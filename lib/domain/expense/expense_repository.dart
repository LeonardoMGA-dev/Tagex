import 'package:tagex/core/state_flow.dart';
import 'package:tagex/domain/expense/model/expense_model.dart';

abstract class ExpenseRepository {
  StateFlow<List<ExpenseModel>> get expensesFlow;

  void createExpense({
    required String name,
    required double amount,
    required DateTime date,
    required List<String> tags,
  });

  Future<List<String>> getTagsSuggestions(String expenseName);
}

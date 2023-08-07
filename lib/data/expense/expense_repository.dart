import 'package:tagex/core/state_flow.dart';
import 'package:tagex/data/expense/expenses.dart';
import 'package:tagex/domain/expense/expense_repository.dart';
import 'package:tagex/domain/expense/model/expense_model.dart';

class ExpenseRepositoryImp extends ExpenseRepository {
  final MutableStateFlow<List<ExpenseModel>> _expensesFlow =
      MutableStateFlow(initialState: expenses);

  @override
  StateFlow<List<ExpenseModel>> get expensesFlow => _expensesFlow;

  @override
  void createExpense({
    required String name,
    required double amount,
    required DateTime date,
    required List<String> tags,
  }) {
    _expensesFlow.update((expenses) {
      expenses.add(ExpenseModel(
        title: name,
        amount: amount,
        date: date,
        tags: tags,
      ));
      return expenses;
    });
  }
}

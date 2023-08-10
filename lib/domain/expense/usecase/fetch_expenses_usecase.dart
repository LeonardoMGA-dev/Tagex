import '../expense_repository.dart';

class FetchExpensesUseCase {
  final ExpenseRepository _expenseRepository;

  FetchExpensesUseCase(this._expenseRepository);

  Future<void> execute() async {
    return await _expenseRepository.fetchExpenses();
  }
}

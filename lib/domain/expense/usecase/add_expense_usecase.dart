import '../expense_repository.dart';

class AddExpenseUseCase {
  final ExpenseRepository _expenseRepository;

  AddExpenseUseCase(this._expenseRepository);

  Future<void> execute({
    required String name,
    required double amount,
    required DateTime date,
    required List<String> tags,
  }) async {
    _expenseRepository.createExpense(
      name: name,
      amount: amount,
      date: date,
      tags: tags,
    );
  }
}

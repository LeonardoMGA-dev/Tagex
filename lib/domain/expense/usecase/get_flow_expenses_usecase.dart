import 'package:tagex/core/state_flow.dart';
import 'package:tagex/domain/expense/model/expense_model.dart';

import '../expense_repository.dart';

class GetFlowExpenseUseCase {
  final ExpenseRepository _expenseRepository;

  GetFlowExpenseUseCase(this._expenseRepository);

  StateFlow<List<ExpenseModel>> execute() {
    return _expenseRepository.expensesFlow;
  }
}

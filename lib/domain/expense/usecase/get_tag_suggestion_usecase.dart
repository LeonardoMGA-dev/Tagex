import 'package:tagex/data/expense/expense_repository.dart';

import '../expense_repository.dart';

class GetTagsSuggestionsUseCase {
  final ExpenseRepository _expenseRepository;

  GetTagsSuggestionsUseCase(this._expenseRepository);

  Future<List<TagModel>> execute(String expenseName) async {
    return await _expenseRepository.getTags(expenseName);
  }
}

import '../expense_repository.dart';

class GetTagsSuggestionsUseCase {
  final ExpenseRepository _expenseRepository;

  GetTagsSuggestionsUseCase(this._expenseRepository);

  Future<List<String>> execute(String expenseName) async {
    return await _expenseRepository.getTagsSuggestions(expenseName);
  }
}

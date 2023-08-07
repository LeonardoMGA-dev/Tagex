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

  @override
  Future<List<String>> getTagsSuggestions(String expenseName) async {
    return predictTagsByExpenseName(expenseName)
        .map((tag) => tag['name'] as String)
        .toList();
  }

  List<Map<String, dynamic>> predictTagsByExpenseName(String expenseName) {
    final List<Map<String, dynamic>> tags = [];
    // get expenses that contain the expenseName
    final expensesWithExpenseName = expenses
        .where((expense) =>
            expense.title.toLowerCase().contains(expenseName.toLowerCase()))
        .toList();

    // loop through the expenses and get the tags and their count
    expensesWithExpenseName.forEach((expense) {
      for (var tag in expense.tags) {
        // check if the tag is already in the tags list
        final int tagIndex = tags.indexWhere((t) => t['name'] == tag);
        if (tagIndex == -1) {
          // if the tag is not in the tags list, add it
          tags.add({'name': tag, 'count': 1});
        } else {
          // if the tag is in the tags list, increment the count
          tags[tagIndex]['count']++;
        }
      }
    });

    // sort the tags by count
    tags.sort((a, b) => b['count'].compareTo(a['count']));
    // return the first 5 tags
    if (tags.length < 5) {
      return tags;
    }
    return tags.sublist(0, 5);
  }
}

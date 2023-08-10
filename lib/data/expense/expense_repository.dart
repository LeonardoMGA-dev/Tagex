import 'package:tagex/core/state_flow.dart';
import 'package:tagex/data/expense/expenses.dart';
import 'package:tagex/data/persistence/db.dart';
import 'package:tagex/domain/expense/expense_repository.dart';
import 'package:tagex/domain/expense/model/expense_model.dart';

class ExpenseRepositoryImp extends ExpenseRepository {
  final TagexDatabase _database;

  ExpenseRepositoryImp(this._database);

  final MutableStateFlow<List<ExpenseModel>> _expensesFlow =
      MutableStateFlow(initialState: []);

  final Set<String> _tags = expenses
      .map((expense) => expense.tags)
      .expand((tags) => tags)
      .toSet()
      .cast<String>();

  @override
  StateFlow<List<ExpenseModel>> get expensesFlow => _expensesFlow;

  @override
  void createExpense({
    required String name,
    required double amount,
    required DateTime date,
    required List<String> tags,
  }) async {
    await _database.createExpense(
        name: name, amount: amount, date: date, tags: tags);
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
  Future<List<TagModel>> getTags(String expenseName) async {
    final tags = predictTagsByExpenseName(expenseName);
    // add tags that are not in the list
    for (var tag in _tags) {
      final int tagIndex = tags.indexWhere((t) => t.name == tag);
      if (tagIndex == -1) {
        tags.add(TagModel(name: tag, coincidences: 0));
      }
    }
    return tags;
  }

  List<TagModel> predictTagsByExpenseName(String expenseName) {
    final List<TagModel> tags = [];
    final expensesWithExpenseName = expenses
        .where((expense) =>
            expenseName.toLowerCase().isSimilar(expense.title.toLowerCase()))
        .toList();
    for (var expense in expensesWithExpenseName) {
      for (var tag in expense.tags) {
        final int tagIndex = tags.indexWhere((t) => t.name == tag);
        if (tagIndex == -1) {
          tags.add(TagModel(name: tag, coincidences: 1));
        } else {
          tags[tagIndex] = tags[tagIndex].copyWith(
            coincidences: tags[tagIndex].coincidences + 1,
          );
        }
      }
    }
    tags.sort((a, b) => b.coincidences.compareTo(a.coincidences));
    return tags;
  }

  @override
  Future<void> fetchExpenses() async {
    final expensesFromDb = await _database.getExpenses();
    _expensesFlow.update((expenses) => expenses..addAll(expensesFromDb));
  }
}

class TagModel {
  final String name;
  final int coincidences;

  TagModel({required this.name, required this.coincidences});

  TagModel copyWith({
    String? name,
    int? coincidences,
  }) {
    return TagModel(
      name: name ?? this.name,
      coincidences: coincidences ?? this.coincidences,
    );
  }
}

extension Util on String {
  bool isSimilar(String other) {
    double calculateJaccardSimilarity(String sentence1, String sentence2) {
      final words1 = sentence1.split(' ');
      final words2 = sentence2.split(' ');

      final intersection = words1.toSet().intersection(words2.toSet());
      final union = words1.toSet().union(words2.toSet());

      return intersection.length / union.length;
    }

    return calculateJaccardSimilarity(this, other) > 0.1;
  }
}

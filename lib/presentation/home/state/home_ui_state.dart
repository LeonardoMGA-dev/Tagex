import 'package:tagex/presentation/components/expense_batch.dart';

class HomeUiState {
  final List<ExpenseModel> expenses;
  final bool isLoading;
  late final double total = expenses.fold<double>(
    0.0,
    (previousValue, element) => previousValue + element.amount,
  );
  late final List<List<ExpenseModel>> groupedExpenses =
      _groupExpensesByDay(expenses);

  HomeUiState({
    this.expenses = const [],
    this.isLoading = false,
  });

  List<List<ExpenseModel>> _groupExpensesByDay(List<ExpenseModel> expenses) {
    final Map<String, List<ExpenseModel>> groupedMap = {};
    for (var expense in expenses) {
      final key = "${expense.date.day}/${expense.date.month}/${expense.date.year}";
      if (groupedMap.containsKey(key)) {
        groupedMap[key]!.add(expense);
      } else {
        groupedMap[key] = [expense];
      }
    }
    print(groupedMap);
    return groupedMap.values.toList();
  }

  HomeUiState copyWith({
    List<ExpenseModel>? expenses,
    bool? isLoading,
    double? total,
  }) {
    return HomeUiState(
      expenses: expenses ?? this.expenses,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

import 'package:tagex/domain/expense/model/expense_model.dart';

class HomeUiState {
  final List<ExpenseModel> expenses;
  final bool isLoading;
  late final double total = expenses.fold<double>(
    0.0,
    (previousValue, element) => previousValue + element.amount,
  );

  HomeUiState({
    this.expenses = const [],
    this.isLoading = false,
  });

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

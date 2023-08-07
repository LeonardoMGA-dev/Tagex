import 'package:tagex/domain/expense/model/expense_model.dart';

class HomeUiState {
  final List<ExpenseModel> expenses;

  HomeUiState({
    this.expenses = const [],
  });

  HomeUiState copyWith({
    List<ExpenseModel>? expenses,
  }) {
    return HomeUiState(
      expenses: expenses ?? this.expenses,
    );
  }
}

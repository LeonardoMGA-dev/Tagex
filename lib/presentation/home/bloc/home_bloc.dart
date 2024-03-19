import 'package:tagex/data/networking/endpoints/get_expense_endpoint.dart';
import 'package:tagex/presentation/components/expense_batch.dart';
import 'package:tagex/presentation/home/state/home_ui_state.dart';
import 'package:tagex/presentation/util/bloc.dart';

import '../../../data/networking/endpoints/GetReportEndpoint.dart';
import '../../../data/util/endpoint.dart';

class HomeBloc extends Bloc<HomeUiState> {
  final GetExpensesEndpoint _getExpensesEndpoint;
  final GetReportEndpoint _getReportEndpoint;

  HomeBloc(
    this._getExpensesEndpoint,
    this._getReportEndpoint,
  );

  void onExpenseAdded(
    HomeUiState state,
  ) {
    updateState((state) {
      return state;
    });
  }

  @override
  HomeUiState initializeState() => HomeUiState();

  @override
  HomeUiState interceptState(HomeUiState state) {
    state.expenses.sort((a, b) => b.date.compareTo(a.date));
    return state.copyWith(
      expenses: state.expenses,
    );
  }

  @override
  void initialize() async {
    super.initialize();
    await getExpenses();
  }

  Future<void> getExpenses() async {
    final response =
        await _getExpensesEndpoint.call(requestDto: EmptyRequest());
    updateState((state) {
      return state.copyWith(
        expenses: response.expenses
            .map((e) => ExpenseModel(
                title: e.name,
                date: DateTime.parse(e.date),
                amount: e.amount,
                tags: e.tags))
            .toList(),
      );
    });
  }

}

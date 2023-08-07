import 'package:tagex/domain/expense/model/expense_model.dart';
import 'package:tagex/domain/expense/usecase/get_flow_expenses_usecase.dart';
import 'package:tagex/presentation/home/state/home_ui_state.dart';
import 'package:tagex/presentation/util/bloc.dart';

class HomeBloc extends Bloc<HomeUiState> {
  final GetFlowExpenseUseCase _getFlowExpenseUseCase;

  HomeBloc(this._getFlowExpenseUseCase);

  void onExpenseAdded(
    HomeUiState state,
  ) {
    updateState((state) {
      return state.copyWith();
    });
  }

  @override
  HomeUiState initializeState() => HomeUiState();

  @override
  HomeUiState interceptState(HomeUiState state) {
    // sort expenses by date
    state.expenses.sort((a, b) => b.date.compareTo(a.date));
    return state.copyWith(
      expenses: state.expenses,
    );
  }

  @override
  void initialize() {
    super.initialize();
    reactTo<List<ExpenseModel>>(
      _getFlowExpenseUseCase.execute(),
      (state, list) {
        return state.copyWith(
          expenses: list,
        );
      },
    );
  }
}

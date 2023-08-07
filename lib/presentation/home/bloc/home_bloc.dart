import 'package:tagex/core/state_flow.dart';
import 'package:tagex/domain/expense/model/expense_model.dart';
import 'package:tagex/domain/expense/usecase/get_flow_expenses_usecase.dart';
import 'package:tagex/presentation/home/state/home_ui_state.dart';

class HomeBloc {
  final GetFlowExpenseUseCase _getFlowExpenseUseCase;

  HomeBloc(this._getFlowExpenseUseCase);

  final MutableStateFlow<HomeUiState> _state = MutableStateFlow(
    initialState: HomeUiState(),
  );
  late final StateFlow<HomeUiState> state = _state.reactTo<List<ExpenseModel>>(
    _getFlowExpenseUseCase.execute(),
    (state, list) {
      return state.copyWith(
        expenses: list,
      );
    },
  );

  void onExpenseAdded(
    HomeUiState state,
  ) {
    _state.update((state) {
      return state.copyWith();
    });
  }
}

import 'package:scope_injector/flutter_scope.dart';
import 'package:tagex/domain/expense/usecase/add_expense_usecase.dart';
import 'package:tagex/domain/expense/usecase/get_flow_expenses_usecase.dart';

class UseCaseDiModule extends Module {
  UseCaseDiModule(ScopedState scopedState) : super(scopedState);

  @override
  void onProvide() {
    provide(() => AddExpenseUseCase(inject()));
    provide(() => GetFlowExpenseUseCase(inject()));
  }
}

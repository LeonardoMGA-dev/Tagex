import 'package:scope_injector/flutter_scope.dart';
import 'package:tagex/domain/expense/usecase/add_expense_usecase.dart';
import 'package:tagex/domain/expense/usecase/fetch_expenses_usecase.dart';
import 'package:tagex/domain/expense/usecase/get_flow_expenses_usecase.dart';
import 'package:tagex/domain/expense/usecase/get_tag_suggestion_usecase.dart';

class UseCaseDiModule extends Module {
  UseCaseDiModule(ScopedState scopedState) : super(scopedState);

  @override
  Future<void> onProvide() async {
    provide(() => AddExpenseUseCase(inject()));
    provide(() => GetFlowExpenseUseCase(inject()));
    provide(() => GetTagsSuggestionsUseCase(inject()));
    provide(() => FetchExpensesUseCase(inject()));
  }
}

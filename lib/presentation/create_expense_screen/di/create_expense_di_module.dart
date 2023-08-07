import 'package:scope_injector/flutter_scope.dart';
import 'package:tagex/presentation/create_expense_screen/bloc/create_expense_bloc.dart';

class CreateExpenseDiModule extends Module {
  CreateExpenseDiModule(ScopedState scopedState) : super(scopedState);

  @override
  void onProvide() {
    provide(() => CreateExpenseBloc(inject(), inject()));
  }
}

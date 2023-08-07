import 'package:scope_injector/scoped_state.dart';
import 'package:tagex/data/expense/expense_repository.dart';
import 'package:tagex/domain/expense/expense_repository.dart';

class RepositoryDiModule extends Module {
  RepositoryDiModule(ScopedState scopedState) : super(scopedState);

  @override
  void onProvide() {
    provide<ExpenseRepository>(() => ExpenseRepositoryImp());
  }
}

import 'package:tagex/domain/expense/usecase/add_expense_usecase.dart';
import 'package:tagex/presentation/create_expense_screen/state/create_expense_ui_state.dart';
import 'package:tagex/presentation/util/bloc.dart';

class CreateExpenseBloc extends Bloc<CreateExpenseUiState> {
  late final AddExpenseUseCase _addExpenseUseCase;

  late final nameController = useTextEditingController();
  late final amountController = useTextEditingController();
  late final dateController = useTextEditingController();

  CreateExpenseBloc(this._addExpenseUseCase);

  void addExpense() {
    final name = nameController.text;
    final amount = amountController.text;
    final date = dateController.text;
    final tags = <String>[];
    final errors = validate(name: name, amount: amount, date: date);
    if (errors.isNotEmpty) {
      updateState((state) => state.copy(errors: errors));
    } else {
      _addExpenseUseCase.execute(
        name: name,
        amount: double.parse(amount),
        date: DateTime.now(),
        tags: tags,
      );
    }
  }

  Map<String, String> validate({
    required String name,
    required String amount,
    required String date,
  }) {
    final errors = <String, String>{};

    if (name.isEmpty) {
      errors["name"] = "Name cannot be empty";
    }

    if (amount.isEmpty) {
      errors["amount"] = "Amount cannot be empty";
    }

    if (date.isEmpty) {
      errors["date"] = "Date cannot be empty";
    }
    return errors;
  }

  @override
  void dispose() {
    print("CreateExpenseBloc disposed");
  }

  @override
  initializeState() => CreateExpenseUiState();
}

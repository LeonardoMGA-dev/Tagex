import 'package:tagex/domain/expense/usecase/add_expense_usecase.dart';
import 'package:tagex/domain/expense/usecase/get_tag_suggestion_usecase.dart';
import 'package:tagex/presentation/create_expense_screen/state/create_expense_ui_state.dart';
import 'package:tagex/presentation/util/bloc.dart';

class CreateExpenseBloc extends Bloc<CreateExpenseUiState> {
  final AddExpenseUseCase _addExpenseUseCase;
  final GetTagsSuggestionsUseCase _getTagsSuggestionsUseCase;

  late final nameController = useTextEditingController();
  late final amountController = useTextEditingController();
  late final dateController = useTextEditingController();

  CreateExpenseBloc(this._addExpenseUseCase, this._getTagsSuggestionsUseCase);

  Future<bool> addExpense() async {
    final name = nameController.text;
    print(await _getTagsSuggestionsUseCase.execute(name));
    final amount = amountController.text;
    final date = dateController.text;
    final tags = <String>[];
    final errors = validate(name: name, amount: amount, date: date);
    if (errors.isNotEmpty) {
      updateState((state) => state.copy(errors: errors));
      return false;
    } else {
      _addExpenseUseCase.execute(
        name: name,
        amount: double.parse(amount),
        date: DateTime.now(),
        tags: tags,
      );
      return true;
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
  initializeState() => CreateExpenseUiState();

  @override
  void initialize() {
    super.initialize();
    nameController.addListener(() async {
      final tags =
          await _getTagsSuggestionsUseCase.execute(nameController.text);
      updateState((state) => state.copy(tagsSuggestions: tags));
    });
  }
}

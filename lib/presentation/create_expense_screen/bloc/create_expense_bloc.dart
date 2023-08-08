import 'package:tagex/data/expense/expense_repository.dart';
import 'package:tagex/domain/expense/usecase/add_expense_usecase.dart';
import 'package:tagex/domain/expense/usecase/get_tag_suggestion_usecase.dart';
import 'package:tagex/presentation/create_expense_screen/state/create_expense_ui_state.dart';
import 'package:tagex/presentation/util/bloc.dart';

class CreateExpenseBloc extends Bloc<CreateExpenseUiState> {
  final AddExpenseUseCase _addExpenseUseCase;
  final GetTagsSuggestionsUseCase _getTagsSuggestionsUseCase;

  final Set<TagModel> tagSuggestions = {};

  late final nameController = useTextEditingController();
  late final amountController = useTextEditingController();
  late final dateController = useTextEditingController();

  CreateExpenseBloc(this._addExpenseUseCase, this._getTagsSuggestionsUseCase);

  Future<bool> addExpense() async {
    final name = nameController.text;
    final amount = amountController.text;
    final date = dateController.text;
    final tags = await withState((state) => state.selectedTags);
    final errors = validate(name: name, amount: amount, date: date);
    if (errors.isNotEmpty) {
      updateState((state) => state.copy(errors: errors));
      return false;
    } else {
      _addExpenseUseCase.execute(
        name: name,
        amount: double.parse(amount),
        date: DateTime.now(),
        tags: tags.map((e) => e.name).toList(),
      );
      return true;
    }
  }

  void addTag(TagModel tag) {
    updateState((state) => state.copy(
          selectedTags: [...state.selectedTags, tag],
          tags: state.tags.where((suggestion) => suggestion != tag).toList(),
        ));
  }

  void removeTag(TagModel tag) {
    // remove the tag from the selected tags and add it to the suggestions
    updateState((state) {
      if (tagSuggestions.contains(tag)) {
        state.tags.add(tag);
        return state.copy(
          selectedTags: state.selectedTags
              .where((selectedTag) => selectedTag != tag)
              .toList(),
        );
      }
      return state.copy(
        selectedTags: state.selectedTags
            .where((selectedTag) => selectedTag != tag)
            .toList(),
        tags: [...state.tags, tag],
      );
    });
  }

  void addAllSuggestions() {
    // add all the suggestions to the selected tags where the coincidences are greater than 0
    updateState((state) {
      final suggestions = state.tags
          .where((suggestion) => suggestion.coincidences > 0)
          .toList();
      // remove the suggestions from the tags
      state.tags.removeWhere((suggestion) => suggestion.coincidences > 0);
      return state.copy(
          selectedTags: [...state.selectedTags, ...suggestions],
        );
    });
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
      tagSuggestions.clear();
      tagSuggestions.addAll(tags);
      updateState((state) => state.copy(tags: tags));
    });
  }
}

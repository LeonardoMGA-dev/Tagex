import 'package:tagex/data/networking/endpoints/create_expense_endpoint.dart';
import 'package:tagex/data/networking/endpoints/get_tags_endpoint.dart';
import 'package:tagex/data/util/endpoint.dart';
import 'package:tagex/presentation/create_expense_screen/state/create_expense_ui_state.dart';
import 'package:tagex/presentation/home/bloc/home_bloc.dart';
import 'package:tagex/presentation/util/bloc.dart';

import '../../../data/networking/endpoints/get_tags_prediction_endpoint.dart';
import '../../components/tag.dart';
import '../../util/debouncer.dart';

class CreateExpenseBloc extends Bloc<CreateExpenseUiState> {
  final CreateExpenseEndpoint _createExpenseEndpoint;
  final GetTagsPredictionsEndpoint _getTagsPredictionsEndpoint;
  final GetTagsEndpoint _getTagsEndpoint;
  final HomeBloc _homeBloc;

  late final nameController = useTextEditingController();
  late final amountController = useTextEditingController();
  late final dateController = useTextEditingController();
  late final _debouncer = Debouncer(milliseconds: 500);

  CreateExpenseBloc(this._createExpenseEndpoint,
      this._getTagsPredictionsEndpoint, this._homeBloc, this._getTagsEndpoint);

  @override
  CreateExpenseUiState interceptState(CreateExpenseUiState state) {
    return state.copy(
      // remove the selected tags from tags
      tags:
          state.tags.where((tag) => !state.selectedTags.contains(tag)).toList(),
      // remove the tags from the suggestions
      selectedTags: state.selectedTags,
      errors: state.errors,
      isLoading: state.isLoading,
    );
  }

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
      await _createExpenseEndpoint.call(
        requestDto: CreateExpenseRequest.build(
          name,
          double.parse(amount),
          date,
          tags.map((e) => e.name).toList(),
        ),
      );
      _homeBloc.getExpenses();
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
      state.tags.add(tag);
      return state.copy(
        selectedTags: state.selectedTags
            .where((selectedTag) => selectedTag != tag)
            .toList(),
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

  void getTagSuggestions(String expenseName) async {
    final state = await withState((state) => state);
    final tags = (state.tags + state.selectedTags)
        .map((e) => TagModel(name: e.name, isSuggestion: false))
        .toList();
    updateState((state) => state.copy(tags: tags, selectedTags: const []));
    _debouncer.run(() async {
      // set all expenses to suggestions
      if (expenseName.isEmpty) {
        // add the suggestions back to the tags
        updateState((state) => state.copy(
            tags: state.tags + state.selectedTags, selectedTags: const []));
        return;
      }
      updateState((state) => state.copy(isLoading: true));
      final response = await _getTagsPredictionsEndpoint.call(
        requestDto: EmptyRequest(),
        query: {"expense": expenseName},
      );
      final tags = response.tags
          .map((e) => TagModel(name: e, isSuggestion: true))
          .toList();
      updateState((state) {
        return state.copy(
          selectedTags: tags,
          isLoading: false,
        );
      });
    });
  }

  void getTags() {
    _getTagsEndpoint.call(requestDto: EmptyRequest()).then((response) {
      updateState((state) => state.copy(
          tags: response.tags
              .map((e) => TagModel(name: e, isSuggestion: false))
              .toList()));
    });
  }

  @override
  void initialize() {
    super.initialize();
    dateController.text = DateTime.now().toString();
    getTags();
  }

  @override
  initializeState() => CreateExpenseUiState();
}

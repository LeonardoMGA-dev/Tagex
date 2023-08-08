import 'package:tagex/data/expense/expense_repository.dart';

class CreateExpenseUiState {
  final bool isLoading;
  final Map<String, String> errors;
  late final isEnable = !isLoading;
  final List<TagModel> tags;
  final List<TagModel> selectedTags;

  CreateExpenseUiState({
    this.isLoading = false,
    this.errors = const {},
    this.tags = const [],
    this.selectedTags = const [],
  });

  CreateExpenseUiState copy({
    bool? isLoading,
    Map<String, String>? errors,
    List<TagModel>? tags,
    List<TagModel>? selectedTags,
  }) {
    return CreateExpenseUiState(
      isLoading: isLoading ?? this.isLoading,
      errors: errors ?? this.errors,
      tags: tags ?? this.tags,
      selectedTags: selectedTags ?? this.selectedTags,
    );
  }
}

class CreateExpenseUiState {
  final bool isLoading;
  final Map<String, String> errors;
  late final isEnable = !isLoading;
  final List<String> tagsSuggestions;

  CreateExpenseUiState({
    this.isLoading = false,
    this.errors = const {},
    this.tagsSuggestions = const [],
  });

  CreateExpenseUiState copy({
    bool? isLoading,
    Map<String, String>? errors,
    List<String>? tagsSuggestions,
  }) {
    return CreateExpenseUiState(
      isLoading: isLoading ?? this.isLoading,
      errors: errors ?? this.errors,
      tagsSuggestions: tagsSuggestions ?? this.tagsSuggestions,
    );
  }
}

class CreateExpenseUiState {
  final bool isLoading;
  final Map<String, String> errors;
  late final isEnable = !isLoading;

  CreateExpenseUiState({
    this.isLoading = false,
    this.errors = const {},
  });

  CreateExpenseUiState copy({
    bool? isLoading,
    Map<String, String>? errors,
  }) {
    return CreateExpenseUiState(
      isLoading: isLoading ?? this.isLoading,
      errors: errors ?? this.errors,
    );
  }
}

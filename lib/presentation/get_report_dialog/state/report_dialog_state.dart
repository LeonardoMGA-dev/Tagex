class ReportDialogUiState {
  final String report;
  final bool isLoading;

  ReportDialogUiState({
    required this.report,
    this.isLoading = false,
  });

  ReportDialogUiState copyWith({
    String? report,
    bool? isLoading,
  }) {
    return ReportDialogUiState(
      report: report ?? this.report,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
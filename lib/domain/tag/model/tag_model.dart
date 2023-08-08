class TagModel {
  final String name;
  final bool isSuggestion;

  TagModel({
    required this.name,
    this.isSuggestion = false,
  });

  TagModel copy({
    String? name,
    bool? isSuggestion,
  }) {
    return TagModel(
      name: name ?? this.name,
      isSuggestion: isSuggestion ?? this.isSuggestion,
    );
  }
}

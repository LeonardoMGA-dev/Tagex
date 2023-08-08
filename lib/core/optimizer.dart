class SuggestionsOptimizer {
  final Map<String, Map<String, int>> _map = {};
  final Set<String> _tags = {};

  void fit(String text, Set<String> values) {
    _tags.addAll(values);
    final map = _map[text];
    if (map == null) {
      _map[text] = {};
    }
    for (var value in values) {
      final map = _map[text];
      if (map == null) {
        _map[text] = {value: 1};
      } else {
        final count = map[value];
        if (count == null) {
          map[value] = 1;
        } else {
          map[value] = count + 1;
        }
      }
    }
  }

  List<Map<String, int>> getSuggestions(String text) {
    final map = _map[text];
    if (map == null) {
      return [];
    }
    final sorted = map.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return [];
  }

  Set<String> get tags => _tags;



  void clear() {
    _map.clear();
    _tags.clear();
  }
}

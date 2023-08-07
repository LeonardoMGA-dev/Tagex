class ExpenseModel {
  final String title;
  final double amount;
  final DateTime date;
  final List<String> tags;

  ExpenseModel({
    required this.title,
    required this.amount,
    required this.date,
    required this.tags,
  });
}

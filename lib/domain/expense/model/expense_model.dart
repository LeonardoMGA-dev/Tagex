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

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'amount': amount,
      'date': date.toIso8601String(),
      'tags': tags,
    };
  }

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      title: json['title'],
      amount: json['amount'],
      date: DateTime.parse(json['date']),
      tags: List<String>.from(json['tags']),
    );
  }
}

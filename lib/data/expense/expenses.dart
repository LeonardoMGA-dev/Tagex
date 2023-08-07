import 'package:tagex/domain/expense/model/expense_model.dart';

final List<ExpenseModel> expenses = [
  ExpenseModel(
    title: "Fuel",
    amount: 300,
    date: DateTime.now(),
    tags: [
      "Car",
      "Transportation",
    ],
  ),
  ExpenseModel(
    title: "Sushi",
    amount: 530.40,
    date: DateTime.now(),
    tags: [
      "Food",
      "Dinner",
      "Girlfriend",
      "Luxury",
    ],
  ),
  ExpenseModel(
    title: "Dog Food",
    amount: 500,
    date: DateTime.now(),
    tags: [
      "Pets",
      "Food",
    ],
  ),
  ExpenseModel(
    title: "Rent",
    amount: 6000,
    date: DateTime.now(),
    tags: [
      "Home",
      "Rent",
      "Basic Needs",
      "Services",
    ],
  ),
  ExpenseModel(
    title: "Netflix",
    amount: 300,
    date: DateTime.now(),
    tags: [
      "Services",
      "Entertainment",
      "Luxury",
    ],
  ),
  ExpenseModel(
    title: "Github copilot",
    amount: 200,
    date: DateTime.now(),
    tags: [
      "Services",
      "Work",
    ],
  ),
  ExpenseModel(
    title: "Potato Chips",
    amount: 20,
    date: DateTime.now(),
    tags: [
      "Food",
      "Snacks",
    ],
  ),
  ExpenseModel(
    title: "Movie theater",
    amount: 1000,
    date: DateTime.now(),
    tags: [
      "Entertainment",
      "Girlfriend",
      "Luxury",
    ],
  ),
];

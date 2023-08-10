import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

import '../../domain/expense/model/expense_model.dart';

class TagexDatabase {
  final String name;
  late final Future<Database> database = _initDatabase();

  TagexDatabase(this.name);

  Future<Database> _initDatabase() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    String dbPath = "${appDocumentDir.path}/$name.db";
    DatabaseFactory dbFactory = databaseFactoryIo;
    return await dbFactory.openDatabase(dbPath);
  }

  Future<Database> get db async => await database;

  Future<int> createExpense({
    required String name,
    required double amount,
    required DateTime date,
    required List<String> tags,
  }) async {
    final expense = ExpenseModel(
      title: name,
      amount: amount,
      date: date,
      tags: tags,
    );
    final store = intMapStoreFactory.store('expenses');
    final id = await store.add(await db, expense.toJson());
    return id;
  }

  Future<List<ExpenseModel>> getExpenses() async {
    final store = intMapStoreFactory.store('expenses');
    final snapshots = await store.find(await db);
    return snapshots.map((snapshot) {
      final expense = ExpenseModel.fromJson(snapshot.value);
      return expense;
    }).toList();
  }
}

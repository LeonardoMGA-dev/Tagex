import 'package:flutter/material.dart';
import 'package:scope_injector/flutter_scope.dart';
import 'package:tagex/presentation/components/tag.dart';
import 'package:tagex/presentation/create_expense_screen/create_expense_screen.dart';
import 'package:tagex/presentation/home/di/home_di_module.dart';

import 'bloc/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ScopedState<HomeScreen> {
  late final HomeBloc _homeBloc = inject();

  @override
  Widget build(BuildContext context) {
    return _homeBloc.build((state) {
      return Column(
        children: [
          Expanded(
            child: Scaffold(
              body: SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 4.0,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: DropdownButtonFormField<String>(
                                  value: "monthly",
                                  items: const [
                                    DropdownMenuItem(
                                      child: Text("Monthly"),
                                      value: "monthly",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("Weekly"),
                                      value: "weekly",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("Fortnightly"),
                                      value: "fortnightly",
                                    ),
                                  ],
                                  onChanged: (value) {},
                                ),
                              ),
                              const SizedBox(
                                width: 8.0,
                              ),
                              Flexible(
                                child: DropdownButtonFormField<String>(
                                  items: const [
                                    DropdownMenuItem(
                                      child: Text("Monthly"),
                                      value: "monthly",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("Weekly"),
                                      value: "weekly",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("Fortnightly"),
                                      value: "fortnightly",
                                    ),
                                  ],
                                  onChanged: (value) {},
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: const Icon(Icons.manage_search_outlined),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Spacer(),
                              Column(
                                children: [
                                  const Text("Total"),
                                  Text(
                                    "\$${state.total}",
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: state.expenses.length,
                          itemBuilder: (context, index) {
                            final expense = state.expenses[index];
                            if (index == state.expenses.length - 1) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 65.0),
                                child: _buildExpense(
                                    title: expense.title,
                                    amount: expense.amount.toString(),
                                    date: expense.date.toString(),
                                    tags: expense.tags),
                              );
                            }
                            return _buildExpense(
                                title: expense.title,
                                amount: expense.amount.toString(),
                                date: expense.date.toString(),
                                tags: expense.tags);
                          }),
                    ),
                  ],
                ),
              ),
              floatingActionButtonAnimator:
                  FloatingActionButtonAnimator.scaling,
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const CreateExpenseScreen();
                  }));
                },
                tooltip: 'Add Expense',
                child: const Icon(Icons.add),
              ),
            ),
          ),
          const Placeholder(
            fallbackHeight: 60,
          )
        ],
      );
    });
  }

  Widget _buildExpense({
    required String title,
    required String amount,
    required String date,
    required List<String> tags,
  }) {
    _homeBloc;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(date),
              const Expanded(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Divider(),
              )),
              Text("\$$amount"),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Wrap(
            spacing: 5,
            runSpacing: 5,
            children: tags.map((e) => Tag(text: e)).toList(),
          ),
        ],
      ),
    );
  }

  @override
  List<Module> provideModules() => [HomeDiModule(this)];
}

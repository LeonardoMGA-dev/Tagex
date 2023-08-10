import 'package:flutter/material.dart';
import 'package:scope_injector/flutter_scope.dart';
import 'package:tagex/presentation/components/expense.dart';
import 'package:tagex/presentation/components/expense_batch.dart';
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
                              Expanded(
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
                              Expanded(
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
                              const Spacer(),
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
                          itemCount: state.groupedExpenses.length,
                          itemBuilder: (context, index) {
                            final expenses = state.groupedExpenses[index];
                            final padding = index == state.expenses.length - 1
                                ? const EdgeInsets.only(bottom: 65.0)
                                : null;
                            return Padding(
                              padding: padding ?? EdgeInsets.zero,
                              child: ExpenseBatch(
                                expenses: expenses,
                              ),
                            );
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

  @override
  List<Module> provideModules() => [HomeDiModule(this)];
}

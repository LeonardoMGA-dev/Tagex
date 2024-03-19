import 'package:flutter/material.dart';
import 'package:scope_injector/flutter_scope.dart';
import 'package:tagex/presentation/components/expense_batch.dart';
import 'package:tagex/presentation/create_expense_screen/create_expense_screen.dart';
import 'package:tagex/presentation/get_report_dialog/get_report_dialog.dart';

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
              appBar: AppBar(
                title: const Text("Tagex"),
              ),
              body: SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 16.0,
                      ),
                      child: Column(
                        children: [
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
              floatingActionButton: Row(
                children: [
                  const Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      _showModal(context, "Report");
                    },
                    tooltip: 'Generate Report',
                    child: const Icon(Icons.add_chart),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return const CreateExpenseScreen();
                      }));
                    },
                    tooltip: 'Add Expense',
                    child: const Icon(Icons.add),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }

  void _showModal(BuildContext context, String text) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const ReportDialog();
      }
    );
  }

  @override
  List<Module> provideModules() => [];
}

import 'package:flutter/material.dart';
import 'package:scope_injector/flutter_scope.dart';
import 'package:tagex/presentation/create_expense_screen/bloc/create_expense_bloc.dart';
import 'package:tagex/presentation/create_expense_screen/di/CreateExpenseDiModule.dart';

class CreateExpenseScreen extends StatefulWidget {
  const CreateExpenseScreen({Key? key}) : super(key: key);

  @override
  State<CreateExpenseScreen> createState() => _CreateExpenseScreenState();
}

class _CreateExpenseScreenState extends ScopedState<CreateExpenseScreen> {
  late final CreateExpenseBloc _bloc = inject();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Builder(builder: (context) {
          return _bloc.build((state) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50,
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back)),
                        const Text(
                          "Add Expense",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Autocomplete(
                    fieldViewBuilder: (BuildContext context,
                        TextEditingController textEditingController,
                        FocusNode focusNode,
                        VoidCallback onFieldSubmitted) {
                      return TextField(
                        onChanged: (value) {
                          _bloc.nameController.text = value;
                        },
                        autofocus: true,
                        decoration: InputDecoration(
                          label: const Text("Name"),
                          errorText: state.errors["name"],
                        ),
                        controller: textEditingController,
                        focusNode: focusNode,
                      );
                    },
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text == '') {
                        return const Iterable<String>.empty();
                      } else {
                        List<String> matches = <String>[];
                        matches.addAll(["sushi", "Gasolina"]);
                        matches.retainWhere((s) {
                          return s
                              .toLowerCase()
                              .contains(textEditingValue.text.toLowerCase());
                        });
                        return matches;
                      }
                    },
                  ),
                  TextField(
                    controller: _bloc.amountController,
                    decoration: InputDecoration(
                      labelText: "Amount",
                      errorText: state.errors["amount"],
                    ),
                  ),
                  const TextField(
                    decoration: InputDecoration(
                      labelText: "Date",
                    ),
                  ),
                  const TextField(
                    decoration: InputDecoration(
                      labelText: "Tags",
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _bloc.addExpense();
                    },
                    child: const Text("Add"),
                  ),
                ],
              ),
            );
          });
        }),
      ),
    );
  }

  @override
  List<Module> provideModules() => [CreateExpenseDiModule(this)];
}

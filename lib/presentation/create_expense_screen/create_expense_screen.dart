import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:scope_injector/flutter_scope.dart';
import 'package:tagex/presentation/components/tag.dart';
import 'package:tagex/presentation/create_expense_screen/bloc/create_expense_bloc.dart';
import 'package:tagex/presentation/create_expense_screen/di/create_expense_di_module.dart';

class CreateExpenseScreen extends StatefulWidget {
  const CreateExpenseScreen({Key? key}) : super(key: key);

  @override
  State<CreateExpenseScreen> createState() => _CreateExpenseScreenState();
}

class _CreateExpenseScreenState extends ScopedState<CreateExpenseScreen> {
  late final CreateExpenseBloc _bloc = inject();

  late final FocusNode _nameFocusNode = FocusNode();
  late final FocusNode _amountFocusNode = FocusNode();
  late final FocusNode _dateFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

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
                  TextField(
                    autofocus: true,
                    decoration: InputDecoration(
                      label: const Text("Name"),
                      errorText: state.errors["name"],
                    ),
                    controller: _bloc.nameController,
                    focusNode: _nameFocusNode,
                    textInputAction: TextInputAction.next,
                  ),
                  TextField(
                      textInputAction: TextInputAction.next,
                      controller: _bloc.amountController,
                      decoration: InputDecoration(
                        labelText: "Amount",
                        errorText: state.errors["amount"],
                      ),
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      )),
                  Focus(
                    onFocusChange: (hasFocus) {
                      if (hasFocus) {
                        _dateFocusNode.unfocus();
                        _amountFocusNode.unfocus();
                        _nameFocusNode.unfocus();
                      }
                    },
                    child: TextField(
                      onTap: () async {
                        DateTime? date = await DatePicker.showDateTimePicker(
                          context,
                          showTitleActions: true,
                          minTime: DateTime(2021, 1, 1),
                          maxTime: DateTime.now(),
                          onChanged: (date) {
                            print('change $date');
                          },
                          onConfirm: (date) {
                            print('confirm $date');
                          },
                          currentTime: DateTime.now(),
                        );
                        if (date != null) {
                          _bloc.dateController.text = date.toString();
                        }
                      },
                      controller: _bloc.dateController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "Date",
                        errorText: state.errors["date"],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Wrap(
                    children: [
                      for (final tag in state.tagsSuggestions)
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Tag(
                            text: tag,
                          ),
                        ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final isCreated = await _bloc.addExpense();
                      if (isCreated) {
                        Navigator.pop(context);
                      }
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

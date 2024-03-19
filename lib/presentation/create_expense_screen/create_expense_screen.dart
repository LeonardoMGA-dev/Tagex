import 'package:flutter/material.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:scope_injector/flutter_scope.dart';
import 'package:tagex/presentation/components/tag.dart';
import 'package:tagex/presentation/create_expense_screen/bloc/create_expense_bloc.dart';
import 'package:tagex/presentation/create_expense_screen/di/create_expense_di_module.dart';
import 'package:tagex/presentation/create_expense_screen/state/create_expense_ui_state.dart';

class CreateExpenseScreen extends StatefulWidget {
  const CreateExpenseScreen({Key? key}) : super(key: key);

  @override
  State<CreateExpenseScreen> createState() => _CreateExpenseScreenState();
}

class _CreateExpenseScreenState extends ScopedState<CreateExpenseScreen> {
  // dependency injection
  late final CreateExpenseBloc _bloc = inject();

  late final FocusNode _nameFocusNode = FocusNode();
  late final FocusNode _amountFocusNode = FocusNode();
  late final FocusNode _dateFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Builder(builder: (context) {
          return _bloc.build((state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
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
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          autofocus: true,
                          decoration: InputDecoration(
                            label: const Text("Name"),
                            errorText: state.errors["name"],
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                          ),
                          controller: _bloc.nameController,
                          focusNode: _nameFocusNode,
                          textInputAction: TextInputAction.next,
                          onChanged: (text) {
                            _bloc.getTagSuggestions(text);
                          },
                        ),
                      ),
                      // loading indicator
                      if (state.isLoading)
                        const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: CircularProgressIndicator(),
                        ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                      textInputAction: TextInputAction.next,
                      controller: _bloc.amountController,
                      decoration: InputDecoration(
                        labelText: "Amount",
                        errorText: state.errors["amount"],
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      )),
                  const SizedBox(
                    height: 10.0,
                  ),
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
                        DateTime? date =
                            await showOmniDateTimePicker(context: context);
                        if (date != null) {
                          _bloc.dateController.text = date.toString();
                        }
                      },
                      controller: _bloc.dateController,
                      readOnly: true,
                      decoration: InputDecoration(
                          labelText: "Date",
                          errorText: state.errors["date"],
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  _buildTagSelector(state),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text(
                    "Tags",
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Flexible(
                    flex: 10,
                    child: SingleChildScrollView(
                      child: Wrap(
                        children: [
                          for (final tag in state.tags)
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Tag(
                                isSuggestion: tag.isSuggestion,
                                text: tag.name,
                                onTap: (name) {
                                  _bloc.addTag(tag);
                                },
                                onLongPress: (name) {},
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            final isCreated = await _bloc.addExpense();
                            if (isCreated) {
                              Navigator.pop(context);
                            }
                          },
                          child: const Text("Add"),
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            final isCreated = await _bloc.addExpense();
                            if (isCreated) {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                                return const CreateExpenseScreen();
                              }));
                            }
                          },
                          child: const Text("Continue adding")
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          });
        }),
      ),
    );
  }

  Column _buildTagSelector(CreateExpenseUiState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Selected tags",
        ),
        const SizedBox(
          height: 5.0,
        ),
        Builder(builder: (context) {
          if (state.selectedTags.isEmpty) {
            return const Padding(
              padding: EdgeInsets.all(5.0),
              child: Text(
                "No tags selected",
                style: TextStyle(color: Colors.grey),
              ),
            );
          }
          return Wrap(
            children: [
              for (final tag in state.selectedTags)
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Tag(
                    isSuggestion: tag.isSuggestion,
                    text: tag.name,
                    onTap: (name) {
                      _bloc.removeTag(tag);
                    },
                  ),
                ),
            ],
          );
        }),
      ],
    );
  }

  @override
  List<Module> provideModules() => [CreateExpenseDiModule(this)];
}

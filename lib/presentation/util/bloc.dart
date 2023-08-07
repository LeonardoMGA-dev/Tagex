import 'package:flutter/material.dart';
import 'package:scope_injector/scoped_state.dart';
import 'package:tagex/core/state_flow.dart';

abstract class Bloc<T> implements Disposable, Initializable {
  final List<TextEditingController> _textEditingControllers = [];

  late final MutableStateFlow<T> _state = MutableStateFlow(
    initialState: initializeState(),
  );

  updateState(T Function(T state) updater) {
    _state.update(updater);
  }

  Widget build(Widget Function(T state) builder) {
    return _state.build(builder);
  }

  TextEditingController useTextEditingController() {
    final controller = TextEditingController();
    _textEditingControllers.add(controller);
    return controller;
  }

  T initializeState();

  @override
  void initialize() {}

  @override
  void dispose() {
    _state.dispose();
    for (final controller in _textEditingControllers) {
      controller.dispose();
    }
    _textEditingControllers.clear();
  }
}

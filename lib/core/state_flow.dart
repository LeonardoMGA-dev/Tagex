import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

abstract class StateFlow<T> {
  final _controller = BehaviorSubject<T>();
  final List<StreamSubscription> _subscriptions = [];

  StateFlow({T? initialState}) {
    if (initialState != null) {
      _controller.add(initialState);
    }
  }

  Stream<T> get stream => _controller.stream;

  void subscribe(Function(T) listener) {
    final subscription = stream.listen(listener);
    _subscriptions.add(subscription);
  }

  void dispose() {
    _controller.close();
    for (final subscription in _subscriptions) {
      subscription.cancel();
    }
    _subscriptions.clear();
  }

  Future<T> get state => stream.first;

  Widget build(Widget Function(T state) builder) {
    return StreamBuilder<T>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return builder(snapshot.data!);
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

class MutableStateFlow<T> extends StateFlow<T> {
  MutableStateFlow({T? initialState}) : super(initialState: initialState);

  void update(T Function(T state) modifyState) async {
    final _state = await stream.first;
    _controller.add(modifyState(_state));
  }

  Future<T> withState(T Function(T state) modifyState) async {
    final currentState = await stream.first;
    return modifyState(currentState);
  }

  MutableStateFlow<T> reactTo<E>(
    StateFlow<E> other,
    T Function(T state, E otherState) mergeState,
  ) {
    final subscription = other.stream.listen((state) {
      update((currentState) => mergeState(currentState, state));
    });
    _subscriptions.add(subscription);
    return this;
  }
}

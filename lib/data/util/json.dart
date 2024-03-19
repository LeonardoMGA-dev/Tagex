import 'package:flutter/cupertino.dart';

abstract class Json {
  final Map<String, dynamic> _json;

  const Json(this._json);

  @protected
  T row<T>(String name) {
    final rowValue = _json[name];
    if (rowValue == null) {
      if (null is T) {
        return null as T;
      }
      throw SerializeException("Row \"$name\" not initialized");
    }
    if (T == double && rowValue is int) {
      return rowValue.toDouble() as T;
    }

    if (T == double && rowValue is String) {
      return double.parse(rowValue) as T;
    }

    if (T == String && rowValue is int) {
      return rowValue.toString() as T;
    }

    return rowValue;
  }

  List<T> rowList<T>(String name, T Function(Map<String, dynamic>) builder) {
    final rowValue = _json[name];
    if (rowValue == null) {
      throw SerializeException("Row \"$name\" not initialized");
    }
    print(rowValue);
    if (rowValue is List) {
      return rowValue.map((e) {
        if (e is String) {
          return e as T;
        }
        return builder(e);
      }).toList();
    }
    throw SerializeException("Row \"$name\" is not a list");
  }

  T setRow<T>(String name, T value) {
    if (value is List<Json>) {
      _json[name] = value.map((e) => e.content).toList();
    } else {
      _json[name] = value;
    }
    return value;
  }

  Map<String, dynamic> get content => _json;
}

class SerializeException implements Exception {
  final String _message;

  SerializeException(this._message);

  @override
  String toString() => _message;
}
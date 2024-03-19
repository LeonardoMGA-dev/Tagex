import 'package:tagex/data/util/json.dart';

import '../../util/endpoint.dart';

class CreateExpenseEndpoint
    extends Endpoint<CreateExpenseRequest, CreateExpenseResponse> {
  CreateExpenseEndpoint(super.dio);

  @override
  String get method => "POST";

  @override
  String get url => "/expenses";

  @override
  CreateExpenseResponse map(Map<String, dynamic> json) {
    return CreateExpenseResponse(json);
  }
}

class CreateExpenseRequest extends Json {
  CreateExpenseRequest(Map<String, dynamic> json) : super(json);

  String get name => row('expense');

  double get amount => row('amount');

  String get date => row('date');

  List<String> get tags => rowList('category', (e) => e as String);

  factory CreateExpenseRequest.build(String name, double amount, String date, List<String> tags) {
    return CreateExpenseRequest({
      'expense': name,
      'amount': amount,
      'date': date,
      'category': tags
    });
  }
}

class CreateExpenseResponse extends Json {
  CreateExpenseResponse(Map<String, dynamic> json) : super(json);
  String? get id => row('id');
  String get name => row('name');
  double get amount => row('amount');
  String get date => row('date');
  List<String> get tags => rowList('category', (e) => e as String);
}

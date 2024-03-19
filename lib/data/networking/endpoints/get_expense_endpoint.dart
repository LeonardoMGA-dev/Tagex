import '../../util/endpoint.dart';
import '../../util/json.dart';

class GetExpensesEndpoint extends Endpoint<EmptyRequest, GetExpenseResponse> {
  GetExpensesEndpoint(super.dio);

  @override
  String get method => "GET";

  @override
  String get url => "/expenses";

  @override
  GetExpenseResponse map(Map<String, dynamic> json) {
    print(json);
    return GetExpenseResponse(json);
  }
}

class GetExpenseResponse extends Json {
  GetExpenseResponse(Map<String, dynamic> json) : super(json);

  List<ExpenseDto> get expenses => rowList('expenses', (e) => ExpenseDto(e));
}

class ExpenseDto extends Json {
  ExpenseDto(Map<String, dynamic> json) : super(json);

  String get id => row('id');

  String get name => row('expense');

  double get amount => row('amount');

  String get date => row('date');

  List<String> get tags => rowList('category', (e) => e as String);
}

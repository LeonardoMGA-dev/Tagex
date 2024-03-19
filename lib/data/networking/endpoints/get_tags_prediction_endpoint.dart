import '../../util/endpoint.dart';
import '../../util/json.dart';

class GetTagsPredictionsEndpoint extends Endpoint<EmptyRequest, GetTasPredictionsResponse> {

  GetTagsPredictionsEndpoint(super.dio);

  @override
  GetTasPredictionsResponse map(Map<String, dynamic> json) {
    return GetTasPredictionsResponse(json);
  }

  @override
  String get method => "GET";

  @override
  String get url => "/tags/predictions";
}

class GetTasPredictionsResponse extends Json {
  GetTasPredictionsResponse(super.json);
  List<String> get tags => rowList('categories', (e) => e as String);
}
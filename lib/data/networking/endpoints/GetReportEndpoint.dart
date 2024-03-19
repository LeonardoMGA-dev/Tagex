import '../../util/endpoint.dart';
import '../../util/json.dart';

class GetReportEndpoint extends Endpoint<EmptyRequest, GetReportResponse> {
  GetReportEndpoint(super.dio);

  @override
  map(Map<String, dynamic> json) {
    return GetReportResponse(json);
  }

  @override
  String get method => "GET";

  @override
  String get url => "/report";
}

class GetReportResponse extends Json {
  GetReportResponse(Map<String, dynamic> json) : super(json);
  late final String report = row('report');
}
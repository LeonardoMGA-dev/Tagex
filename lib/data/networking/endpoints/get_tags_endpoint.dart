import 'package:tagex/data/util/json.dart';

import '../../util/endpoint.dart';

class GetTagsEndpoint extends Endpoint<EmptyRequest, GetTagsResponse> {
  GetTagsEndpoint(super.dio);

  @override
  GetTagsResponse map(Map<String, dynamic> json) {
    return GetTagsResponse(json);
  }

  @override
  String get method => "GET";

  @override
  String get url => "/tags";
}

class GetTagsResponse extends Json {
  GetTagsResponse(super.json);
  late final List<String> tags = rowList('categories', (e) => e as String);
}

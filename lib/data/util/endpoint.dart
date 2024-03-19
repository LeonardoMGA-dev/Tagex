import 'package:dio/dio.dart';

import 'json.dart';

abstract class Endpoint<T extends Json, E extends Json> {
  final Dio _dio;

  Endpoint(this._dio);

  Future<E> call({
    T? requestDto,
    Map<String, String>? params,
    Map<String, String>? query,
  }) async {
    final response = await _dio.request(
      buildPath(params ?? {}),
      queryParameters: query,
      options: Options(method: method),
      data: requestDto?.content,
    );
    return map(response.data);
  }

  String get url;

  String get method;

  E map(Map<String, dynamic> json);

  String buildPath(Map<String, String> params) => url.replaceAllMapped(
      RegExp(r":(\w+)"), (match) => params[match.group(1)] ?? "");
}

class EmptyRequest extends Json {
  EmptyRequest() : super({});
}

class EmptyResponse extends Json {
  EmptyResponse() : super({});
}

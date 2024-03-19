import 'package:dio/dio.dart';
import 'package:scope_injector/scoped_state.dart';
import 'package:tagex/data/networking/constants.dart';
import 'package:tagex/data/networking/endpoints/GetReportEndpoint.dart';
import 'package:tagex/data/networking/endpoints/create_expense_endpoint.dart';
import 'package:tagex/data/networking/endpoints/get_expense_endpoint.dart';
import 'package:tagex/data/networking/endpoints/get_tags_prediction_endpoint.dart';

import 'endpoints/get_tags_endpoint.dart';

class EndpointDiModule extends Module {
  EndpointDiModule(super.scopedState);

  @override
  void onProvide() {
    provide(() => Dio(
          BaseOptions(
            baseUrl: BASE_URL,
          ),
        ));
    provide(() => GetExpensesEndpoint(inject()));
    provide(() => CreateExpenseEndpoint(inject()));
    provide(() => GetTagsPredictionsEndpoint(inject()));
    provide(() => GetTagsEndpoint(inject()));
    provide(() => GetReportEndpoint(inject()));
  }
}

import 'package:tagex/presentation/get_report_dialog/state/report_dialog_state.dart';

import '../../../data/networking/endpoints/GetReportEndpoint.dart';
import '../../../data/util/endpoint.dart';
import '../../util/bloc.dart';

class ReportDialogBloc extends Bloc<ReportDialogUiState> {

  final GetReportEndpoint _getReportEndpoint;

  ReportDialogBloc(
    this._getReportEndpoint,
  );

  @override
  void initialize() {
    super.initialize();
    getReport();
  }

  void getReport() async {
    final response = await _getReportEndpoint.call(requestDto: EmptyRequest());
    updateState((state) {
      return state.copyWith(
        report: response.report,
      );
    });
  }

  @override
  ReportDialogUiState initializeState() => ReportDialogUiState(report: "");

}
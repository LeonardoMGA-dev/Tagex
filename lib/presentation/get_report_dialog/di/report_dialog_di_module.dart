import 'package:scope_injector/flutter_scope.dart';

import '../bloc/report_dialog_bloc.dart';

class ReportDialogDiModule extends Module {
  ReportDialogDiModule(super.scopedState);


  @override
  void onProvide() {
    provide(() => ReportDialogBloc(inject()));
  }
}
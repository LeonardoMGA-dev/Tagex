import 'package:flutter/material.dart';
import 'package:scope_injector/flutter_scope.dart';

import 'bloc/report_dialog_bloc.dart';
import 'di/report_dialog_di_module.dart';

class ReportDialog extends StatefulWidget {
  const ReportDialog({Key? key}) : super(key: key);

  @override
  State<ReportDialog> createState() => _ReportDialogState();
}

class _ReportDialogState extends ScopedState<ReportDialog> {
  late final ReportDialogBloc _reportDialogBloc = inject();

  @override
  Widget build(BuildContext context) {
    return _reportDialogBloc.build((state) {
      return AlertDialog(
        title: const Text('AI Report'),
        content: (state.report.isNotEmpty)
            ? SingleChildScrollView(child: Text(state.report))
            : const Center(child: CircularProgressIndicator()),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close'),
          ),
        ],
      );
    });
  }

  @override
  List<Module> provideModules() => [
    ReportDialogDiModule(this),
  ];
}

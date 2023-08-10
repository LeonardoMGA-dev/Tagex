import 'package:scope_injector/flutter_scope.dart';
import 'package:tagex/data/persistence/db.dart';

class DataDiModule extends Module {
  DataDiModule(ScopedState scopedState) : super(scopedState);

  @override
  onProvide() {
    provide(() => TagexDatabase("tagex"));
  }
}

import 'package:scope_injector/flutter_scope.dart';
import 'package:tagex/presentation/home/bloc/home_bloc.dart';

class HomeDiModule extends Module {
  HomeDiModule(ScopedState scopedState) : super(scopedState);

  @override
  onProvide() {
    provide(() => HomeBloc(inject(), inject()));
  }
}

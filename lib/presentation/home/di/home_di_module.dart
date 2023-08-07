import 'package:scope_injector/flutter_scope.dart';
import 'package:tagex/presentation/home/bloc/home_bloc.dart';

class HomeDiModule extends Module {
  HomeDiModule(ScopedState scopedState) : super(scopedState);

  @override
  void onProvide() {
    provide(() => HomeBloc(inject()));
  }
}

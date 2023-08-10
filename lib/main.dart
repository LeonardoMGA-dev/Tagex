import 'package:flutter/material.dart';
import 'package:scope_injector/flutter_scope.dart';
import 'package:tagex/data/di/data_di_module.dart';
import 'package:tagex/data/di/usecase_di_module.dart';
import 'package:tagex/presentation/home/home_screen.dart';

import 'data/di/repository_di_module.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ScopedState<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tagex',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }

  @override
  List<Module> provideModules() =>
      [UseCaseDiModule(this), RepositoryDiModule(this), DataDiModule(this)];
}

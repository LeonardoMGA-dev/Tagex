import 'package:flutter/material.dart';
import 'package:scope_injector/flutter_scope.dart';
import 'package:tagex/data/networking/endpoint_di_module.dart';
import 'package:tagex/presentation/home/di/home_di_module.dart';
import 'package:tagex/presentation/home/home_screen.dart';
import 'package:tagex/state/state_di_module.dart';

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
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.white, //<-- SEE HERE
              displayColor: Colors.white, //<-- SEE HERE
              fontFamily: "Open Sans",
            ),
        cardTheme: const CardTheme(
          color: Colors.black38,
          shadowColor: Colors.black38,
          elevation: 4,
          shape: RoundedRectangleBorder(),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purple,
          secondary: Colors.purpleAccent,
          brightness: Brightness.dark,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
        ),
        scaffoldBackgroundColor: Colors.black26,
      ),
      home: const HomeScreen(),
    );
  }

  @override
  List<Module> provideModules() =>
      [EndpointDiModule(this), StateDiModule(this), HomeDiModule(this)];
}

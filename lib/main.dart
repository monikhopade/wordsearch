import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'route/route.dart';
import 'bloc/word_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Word Search App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: Routes.splashScreen, 
        onGenerateRoute: Routes.generateRoute,
      builder: (context, child) {
        return BlocProvider(
          create: (_) => WordBloc(),
          child: child!,
        );
      }
    );
  }
}

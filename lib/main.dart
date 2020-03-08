import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:strength_project/core/global.dart';
import 'package:strength_project/core/services/auth.dart';
import 'package:strength_project/core/services/router.dart';
import 'core/viewmodels/exercise_viewmodel.dart';
import 'package:strength_project/locator.dart';

import 'core/viewmodels/workout_viewmodel.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            builder: (context) => locator<CreateExerciseViewModel>()),
        ChangeNotifierProvider(
            builder: (context) => locator<CreateWorkoutViewModel>()),
        ChangeNotifierProvider(builder: (context) => locator<AuthService>()),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Strength Project',
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Router.generateRoute,
        initialRoute: rootPageRoute,
        darkTheme: ThemeData.dark(),
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
      ),
    );
  }
}

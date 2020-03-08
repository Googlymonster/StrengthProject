import 'package:flutter/material.dart';
import 'package:strength_project/ui/pages/exercise_view/exercises.dart';
import 'package:strength_project/ui/pages/login.dart';
import 'package:strength_project/ui/pages/no_route.dart';
import 'package:strength_project/ui/pages/profile_view/profile.dart';
import 'package:strength_project/ui/pages/root_page.dart';
import 'package:strength_project/ui/pages/settings_view/settings.dart';
import 'package:strength_project/ui/pages/workout_view/workouts.dart';
import 'package:strength_project/ui/pages/calender_view/workouts_date.dart';
import 'package:strength_project/core/global.dart';
import 'package:strength_project/ui/pages/home.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (_) => Home());
      case loginRoute:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case profileRoute:
        return MaterialPageRoute(builder: (_) => Profile());
      case workoutRoute:
        return MaterialPageRoute(builder: (_) => Workouts());
      case workoutDateRoute:
        return MaterialPageRoute(builder: (_) => WorkoutsDate());
      case exerciseRoute:
        return MaterialPageRoute(builder: (_) => Exercises());
      case settingsRoute:
        return MaterialPageRoute(builder: (_) => Settings());
      case rootPageRoute:
        return MaterialPageRoute(builder: (_) => RootPage());
      default:
        return MaterialPageRoute(builder: (_) => NoRoute());
    }
  }
}

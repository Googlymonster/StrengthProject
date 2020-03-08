import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:strength_project/core/models/workout.dart';
import 'package:strength_project/core/services/api.dart';
import 'package:strength_project/core/viewmodels/workout_viewmodel.dart';
import 'package:strength_project/locator.dart';

class CreateWorkoutDateViewModel extends ChangeNotifier {
  final Api _api = locator<Api>("dates");

  CreateWorkoutViewModel _workoutApi = CreateWorkoutViewModel();

  // Properties
  List<Workout> _workouts;
  bool isLoading = false;

  List<Workout> get workouts {
    return _workouts;
  }

  void populateWorkoutsList() async {
    _workouts = await _workoutApi.fetchWorkouts();
    isLoading = true;
  }

  void addWorkout(Workout workout) {
    _workouts.add(workout);
  }

  Future<List<Workout>> fetchWorkoutDates() async {
    var result = await _api.getDataCollection();
    _workouts =
        result.documents.map((doc) => Workout.fromJson(doc.data)).toList();
  }
}

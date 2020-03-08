import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:strength_project/core/models/exercise.dart';
import 'package:strength_project/core/models/workout.dart';
import 'package:strength_project/core/models/workout_exercise.dart';
import 'package:strength_project/core/models/workout_set.dart';
import 'package:strength_project/core/services/api.dart';
import 'package:strength_project/core/viewmodels/exercise_viewmodel.dart';
import 'package:strength_project/locator.dart';

class CreateWorkoutViewModel extends ChangeNotifier {
  final Api _api = locator<Api>("workouts");

  CreateExerciseViewModel _exerciseApi = CreateExerciseViewModel();

  // Properties
  List<Workout> _workouts = [];
  String _name;
  Workout _workout;
  WorkoutExercise _workoutExercise;
  List<WorkoutExercise> _workoutExercises = [];
  List<Exercise> fullWorkoutExercisesList;
  List<WorkoutSet> _workoutSets = [];
  bool isLoading = false;

  // Getters
  Workout get workout {
    return _workout;
  }

  WorkoutExercise get workoutExercise {
    return _workoutExercise;
  }

  List<WorkoutExercise> get workoutExercises {
    return _workoutExercises;
  }

  int get workoutExerciseLength {
    return workoutExercises.length;
  }

  // Method to update workout from a document
  void documentToWorkoutApi(DocumentSnapshot document) {
    _workout = Workout.fromJson(document.data);
    this._updateWorkoutExercises(_workout.workoutExercises);
    this.newName(_workout.name);
  }

// Method to populate the full workout list from the available exercises
  void populateWorkoutExercisesList() async {
    fullWorkoutExercisesList = await _exerciseApi.fetchExercises();
    isLoading = true;
  }

  Future<List<Workout>> fetchWorkouts() async {
    var result = await _api.getDataCollection();
    _workouts =
        result.documents.map((doc) => Workout.fromJson(doc.data)).toList();
    return _workouts;
  }

  Stream<QuerySnapshot> fetchWorkoutsAsStream() {
    return _api.streamDataCollection();
  }

  List<WorkoutExercise> fetchWorkoutExercises() {
    if (workoutExercises != null && workoutExercises.isNotEmpty) {
      return workoutExercises;
    } else {
      return _workoutExercises = [];
    }
  }

  // List<WorkoutSet> fetchWorkoutSets(String id) {
  //   if (_workoutSets != null && _workoutSets.isNotEmpty) {
  //     return _workoutSets;
  //   }
  //   return _workoutSets = [];
  // }

  // Future<Workout> getWorkoutById(String id) async {
  //   var doc = await _api.getDocumentById(id);
  //   return Workout.fromJson(doc.data);
  // }

  Future removeWorkout(String id) async {
    await _api.removeDocument(id);
    return;
  }

  Future updateWorkout(String id) async {
    _workout = Workout(name: _name, workoutExercises: workoutExercises);
    await _api.updateDocument(_workout.toJson(), id);
    return;
  }

  Future addWorkout() async {
    _workout = Workout(name: _name, workoutExercises: workoutExercises);
    await _api.addDocument(_workout.toJson());
    return;
  }

  void addWorkoutExercise(Exercise exercise) {
    _workoutExercise = WorkoutExercise.fromExercise(exercise);
    workoutExercises.add(_workoutExercise);
    notifyListeners();
  }

// Method to add workout set to workout exercise
  void addWorkoutSet(
      int workoutIndex, int exerciseIndex, int reps, num weight) {
    final WorkoutSet workoutSet = WorkoutSet(reps: reps, weight: weight);
    // _workouts[workoutIndex]
    _workoutExercises[exerciseIndex].workoutSets.add(workoutSet);
    notifyListeners();
  }

// Method to remove workout set from a workout exercise
  void removeWorkoutSet(int exerciseIndex, int setIndex) {
    _workoutExercises[exerciseIndex].workoutSets.removeAt(setIndex);
    notifyListeners();
  }

// Method to remove a workout exercise at a index
  void removeWorkoutExercise(int index) {
    workoutExercises.removeAt(index);
    notifyListeners();
  }

// Private method to update the list of selected workout exercises
  void _updateWorkoutExercises(List<WorkoutExercise> newWorkoutExercises) {
    _workoutExercises = newWorkoutExercises;
    notifyListeners();
  }

// Method to clear list of workout exercises
  void clearWorkoutExercises() {
    _workoutExercises = [];
    notifyListeners();
  }

// Method to update name of workout
  void newName(String name) {
    this._name = name;
    notifyListeners();
  }

// Overrides the dispose method to clear the workout exercise list
  @override
  void dispose() {
    this.clearWorkoutExercises();
    super.dispose();
  }
}

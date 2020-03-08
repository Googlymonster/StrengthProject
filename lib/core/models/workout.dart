import 'package:flutter/material.dart';
import 'package:strength_project/core/models/workout_exercise.dart';
import 'package:json_annotation/json_annotation.dart';

part 'workout.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class Workout {
  // Properties
  final String uid;
  final String name;
  final List<WorkoutExercise> workoutExercises;

  // Named Constructor
  Workout({this.uid, @required this.name, this.workoutExercises});

  // Transpose Workout object to map
  Map<String, dynamic> toJson() => _$WorkoutToJson(this);

  // Factory Constructor to create instances of Workout class from a map object
  factory Workout.fromJson(Map<String, dynamic> json) =>
      _$WorkoutFromJson(json);

  /// Custom comparator logic below so that even if two objects
  /// are not the same insance they will return true when compared
  /// if there members are equal.
  @override
  int get hashCode => name.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Workout && name == other.name;
}

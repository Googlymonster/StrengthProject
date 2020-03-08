import 'package:flutter/material.dart';
import 'package:strength_project/core/models/workout_set.dart';
import 'package:strength_project/core/models/exercise.dart';
import 'package:json_annotation/json_annotation.dart';

part 'workout_exercise.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class WorkoutExercise extends Exercise {
  final String uid;
  final List<WorkoutSet> workoutSets;

  WorkoutExercise({@required name, this.uid, this.workoutSets})
      : super(name: name);

  factory WorkoutExercise.fromExercise(Exercise exercise) => WorkoutExercise(
        name: exercise.name,
        uid: exercise.uid,
        workoutSets: [],
      );

  factory WorkoutExercise.fromJson(Map<String, dynamic> json) =>
      _$WorkoutExerciseFromJson(json);

  Map<String, dynamic> toJson() => _$WorkoutExerciseToJson(this);
}

import 'package:flutter/material.dart';
import 'package:strength_project/core/models/workout.dart';
import 'package:json_annotation/json_annotation.dart';

part 'workout_date.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class WorkoutDate extends Workout {
  // Properties
  final DateTime date;
  final Workout workout;

  // Named Constructor
  WorkoutDate({@required this.date, @required this.workout});

  // Transpose Workout object to map
  Map<String, dynamic> toJson() => _$WorkoutDateToJson(this);

  factory WorkoutDate.fromJson(Map<String, dynamic> json) =>
      _$WorkoutDateFromJson(json);
}

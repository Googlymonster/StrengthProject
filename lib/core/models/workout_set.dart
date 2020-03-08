import 'package:json_annotation/json_annotation.dart';

part 'workout_set.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class WorkoutSet {
  final int reps;
  final num weight;

  WorkoutSet({this.reps = 0, this.weight = 0});

  factory WorkoutSet.fromJson(Map<String, dynamic> json) =>
      _$WorkoutSetFromJson(json);

  Map<String, dynamic> toJson() => _$WorkoutSetToJson(this);
}

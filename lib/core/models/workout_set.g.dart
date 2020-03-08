// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_set.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkoutSet _$WorkoutSetFromJson(Map json) {
  return WorkoutSet(
    reps: json['reps'] as int,
    weight: json['weight'] as num,
  );
}

Map<String, dynamic> _$WorkoutSetToJson(WorkoutSet instance) =>
    <String, dynamic>{
      'reps': instance.reps,
      'weight': instance.weight,
    };

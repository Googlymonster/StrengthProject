// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_exercise.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkoutExercise _$WorkoutExerciseFromJson(Map json) {
  return WorkoutExercise(
    name: json['name'],
    uid: json['uid'] as String,
    workoutSets: (json['workoutSets'] as List)
        ?.map((e) => e == null
            ? null
            : WorkoutSet.fromJson((e as Map)?.map(
                (k, e) => MapEntry(k as String, e),
              )))
        ?.toList(),
  );
}

Map<String, dynamic> _$WorkoutExerciseToJson(WorkoutExercise instance) =>
    <String, dynamic>{
      'name': instance.name,
      'uid': instance.uid,
      'workoutSets': instance.workoutSets?.map((e) => e?.toJson())?.toList(),
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Workout _$WorkoutFromJson(Map json) {
  return Workout(
    uid: json['uid'] as String,
    name: json['name'] as String,
    workoutExercises: (json['workoutExercises'] as List)
        ?.map((e) => e == null
            ? null
            : WorkoutExercise.fromJson((e as Map)?.map(
                (k, e) => MapEntry(k as String, e),
              )))
        ?.toList(),
  );
}

Map<String, dynamic> _$WorkoutToJson(Workout instance) => <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'workoutExercises':
          instance.workoutExercises?.map((e) => e?.toJson())?.toList(),
    };

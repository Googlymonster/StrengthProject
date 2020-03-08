// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_date.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkoutDate _$WorkoutDateFromJson(Map json) {
  return WorkoutDate(
    date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
    workout: json['workout'] == null
        ? null
        : Workout.fromJson((json['workout'] as Map)?.map(
            (k, e) => MapEntry(k as String, e),
          )),
  );
}

Map<String, dynamic> _$WorkoutDateToJson(WorkoutDate instance) =>
    <String, dynamic>{
      'date': instance.date?.toIso8601String(),
      'workout': instance.workout?.toJson(),
    };

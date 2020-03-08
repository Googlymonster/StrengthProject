import 'package:flutter/material.dart';

class Exercise {
  // Properties
  final String uid;
  final String name;

  // Constructor
  Exercise({
    @required this.name,
    this.uid,
  });

  // Constructor for creating Object from map
  Exercise.fromMap(Map<String, dynamic> data, String id)
      : uid = id,
        name = data['name'];

  // Helper to map the object to Map
  Map<String, Object> toMap() => {
        "uid": uid,
        "name": name,
      };

  /// Custom comparator logic below so that even if two objects
  /// are not the same insance they will return true when compared
  /// if there members are equal.
  @override
  int get hashCode => name.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Exercise && name == other.name;
}

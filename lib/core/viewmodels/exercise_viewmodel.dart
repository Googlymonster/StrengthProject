import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:strength_project/core/models/exercise.dart';
import 'package:strength_project/core/services/api.dart';
import 'package:strength_project/locator.dart';

class CreateExerciseViewModel extends ChangeNotifier {
  Api _api = locator<Api>('exercises');

  List<Exercise> _exercises;

  List<Exercise> get exercises {
    return this._exercises;
  }

  Future<List<Exercise>> fetchExercises() async {
    var result = await _api.getDataCollection();
    _exercises = result.documents
        .map((doc) => Exercise.fromMap(doc.data, doc.documentID))
        .toList();
    return _exercises;
  }

  Stream<QuerySnapshot> fetchExercisesAsStream() {
    return _api.streamDataCollection();
  }

  Future<Exercise> getExerciseById(String id) async {
    var doc = await _api.getDocumentById(id);
    return Exercise.fromMap(doc.data, doc.documentID);
  }

  Future removeExercise(String id) async {
    await _api.removeDocument(id);
    return;
  }

  Future updateExercise(Exercise data, String id) async {
    await _api.updateDocument(data.toMap(), id);
    return;
  }

  Future addExercise(Exercise data) async {
    await _api.addDocument(data.toMap());
    return;
  }
}

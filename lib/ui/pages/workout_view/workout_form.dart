import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:strength_project/core/models/workout_exercise.dart';
import 'package:strength_project/core/viewmodels/workout_viewmodel.dart';
import 'package:strength_project/ui/pages/workout_view/widgets/addExerciseButton.dart';
import 'package:strength_project/ui/pages/workout_view/widgets/workoutExerciseCard.dart';
import 'package:strength_project/ui/widgets/myNameFormField.dart';
import 'package:strength_project/ui/widgets/mySubmitButton.dart';

class WorkoutsForm extends StatefulWidget {
  WorkoutsForm({Key key, this.workoutApi, this.document, this.workoutIndex})
      : super(key: key);
  final DocumentSnapshot document;
  final int workoutIndex;
  final CreateWorkoutViewModel workoutApi;
  @override
  _WorkoutsFormState createState() => _WorkoutsFormState();
}

class _WorkoutsFormState extends State<WorkoutsForm> {
  final _formKey = GlobalKey<FormState>();
  CreateWorkoutViewModel _workoutApi;
  TextEditingController _workoutNameController;
  List<WorkoutExercise> workoutExercises;
  String _formType = "Submit";
  int _workoutIndex;
  int _exerciseIndex;
  String _documentId;

  @override
  initState() {
    _workoutNameController = TextEditingController();
    _workoutApi = widget.workoutApi;
    workoutExercises = [];
    if (widget.document != null) {
      _workoutNameController.text = widget.document['name'];
      _workoutIndex = widget.workoutIndex;
      _workoutApi.documentToWorkoutApi(widget.document);
      _documentId = widget.document.documentID;
      _formType = "Update";
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _workoutNameController.dispose();
    _workoutApi.clearWorkoutExercises();
  }

  void handleSubmit() async {
    if (_formType == "Submit") {
      if (_formKey.currentState.validate()) {
        _workoutApi.newName(_workoutNameController.text);
        await _workoutApi
            .addWorkout()
            .then((result) => {
                  Navigator.pop(context),
                  _workoutNameController.clear(),
                })
            .catchError((err) => print(err));
      }
    } else {
      if (_formKey.currentState.validate()) {
        _workoutApi.newName(_workoutNameController.text);
        await _workoutApi
            .updateWorkout(_documentId)
            .then((result) => {
                  Navigator.pop(context),
                  _workoutNameController.clear(),
                })
            .catchError((err) => print(err));
      }
    }
  }

  void refreshCallback(CreateWorkoutViewModel workoutApi) {
    setState(() {
      this.workoutExercises = workoutApi.fetchWorkoutExercises();
    });
  }

  Widget _buildExerciseCardList() {
    if (_workoutApi.workoutExercises.isNotEmpty ||
        _workoutApi.workoutExercises != null ||
        _workoutApi.workout != null) {
      return SizedBox(
        height: 550,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: _workoutApi.workoutExerciseLength,
            itemBuilder: (BuildContext context, int index) {
              _exerciseIndex = index;
              return WorkoutExerciseCard(
                workoutIndex: _workoutIndex,
                exercise: _workoutApi.workoutExercises[index],
                exerciseIndex: _exerciseIndex,
                workoutApi: _workoutApi,
                callback: refreshCallback,
              );
            }),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(child: Text('No exercises yet')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: ListView(
            children: <Widget>[
              MyNameFormField(
                  controller: _workoutNameController, label: 'Name of Workout'),
              _buildExerciseCardList(),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: AddWorkoutExerciseButton(
                    workoutApi: _workoutApi,
                    showModal: ExerciseListModal.showListModal,
                    key: Key('addWorkoutExerciseWidget'),
                    callback: refreshCallback,
                  )),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: MySubmitButton(handleSubmit, _formType)),
            ],
          ),
        ),
      ),
    );
  }
}

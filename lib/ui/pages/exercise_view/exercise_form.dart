import 'package:flutter/material.dart';
import 'package:strength_project/ui/widgets/myNameFormField.dart';
import 'package:strength_project/ui/widgets/mySubmitButton.dart';
import 'package:strength_project/core/models/exercise.dart';
import 'package:strength_project/core/viewmodels/exercise_viewmodel.dart';

class ExerciseForm extends StatefulWidget {
  ExerciseForm({Key key, this.exercise}) : super(key: key);

  final Exercise exercise;

  @override
  _ExerciseFormState createState() => _ExerciseFormState();
}

class _ExerciseFormState extends State<ExerciseForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _exerciseNameController;
  CreateExerciseViewModel _exerciseApi = CreateExerciseViewModel();
  Exercise _currentExercise;
  String _formType = "Submit";

  @override
  initState() {
    _exerciseNameController = TextEditingController();
    if (widget.exercise != null) {
      _exerciseNameController.text = widget.exercise.name;
      _currentExercise = widget.exercise;
      _formType = "Update";
    }
    super.initState();
  }

  void handleSubmit() async {
    if (_formType == "Submit") {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
        Exercise _exercise = Exercise(name: _exerciseNameController.text);
        await _exerciseApi
            .addExercise(_exercise)
            .then((result) => {
                  Navigator.pop(context),
                  _exerciseNameController.clear(),
                })
            .catchError((err) => print(err));
      }
    } else {
      if (_formKey.currentState.validate()) {
        Exercise _exercise = Exercise(
            name: _exerciseNameController.text, uid: _currentExercise.uid);
        await _exerciseApi
            .updateExercise(_exercise, _exercise.uid)
            .then((result) => {
                  Navigator.pop(context),
                  _exerciseNameController.clear(),
                })
            .catchError((err) => print(err));
      }
    }
  }

  String nameValidator(String value) {
    if (value.isEmpty) {
      return 'Please enter name';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20.0),
        child: Form(
            key: _formKey,
            child: Scaffold(
                body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                MyNameFormField(
                    controller: _exerciseNameController,
                    label: 'Enter Name of Exercise'),
                SizedBox(
                  height: 20.0,
                ),
                Center(child: MySubmitButton(handleSubmit, _formType)),
              ],
            ))));
  }
}

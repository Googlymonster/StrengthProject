import 'package:flutter/material.dart';
import 'package:strength_project/core/models/exercise.dart';
import 'package:strength_project/core/viewmodels/workout_viewmodel.dart';

class AddWorkoutExerciseButton extends StatelessWidget {
  final Function showModal;
  final CreateWorkoutViewModel workoutApi;
  final Function callback;
  AddWorkoutExerciseButton(
      {Key key, this.showModal, this.workoutApi, this.callback})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      key: Key('addExercisesButton'),
      color: Colors.red[400],
      child: Text(
        'Add Exercise',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        showModal(context, workoutApi).then((Exercise exercise) {
          if (exercise != null) {
            workoutApi.addWorkoutExercise(exercise);
            print('$exercise has been added');
            callback(workoutApi);
          } else {
            print('No exercise selected.');
          }
        });
      },
    );
  }
}

class ExerciseListModal {
  static Future<Exercise> showListModal(
      BuildContext context, CreateWorkoutViewModel workoutApi) {
    return showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        builder: (BuildContext context) {
          workoutApi.populateWorkoutExercisesList();
          return workoutApi.isLoading
              ? Container(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  child: ListView.builder(
                    itemCount: workoutApi.fullWorkoutExercisesList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        color: Colors.blue[400],
                        margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        elevation: 5,
                        child: ListTile(
                          key: Key('listItem$index'),
                          title: Text(
                            workoutApi.fullWorkoutExercisesList[index].name,
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.white),
                          ),
                          onTap: () {
                            Navigator.of(context).pop(
                                workoutApi.fullWorkoutExercisesList[index]);
                          },
                        ),
                      );
                    },
                  ),
                )
              : Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
        });
  }
}

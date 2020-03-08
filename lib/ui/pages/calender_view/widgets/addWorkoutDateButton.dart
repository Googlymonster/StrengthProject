import 'package:flutter/material.dart';
import 'package:strength_project/core/models/workout.dart';
import 'package:strength_project/core/viewmodels/workoutDate_viewmodel.dart';

class AddWorkoutDateButton extends StatelessWidget {
  final Function showModal;
  final CreateWorkoutDateViewModel workoutDateApi;
  final Function callback;

  AddWorkoutDateButton(
      {Key key, this.showModal, this.workoutDateApi, this.callback})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      key: Key('addWorkoutButton'),
      color: Colors.red[400],
      child: Text(
        'Add Exercise',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        showModal(context, workoutDateApi).then((Workout workout) {
          if (workout != null) {
            workoutDateApi.addWorkout(workout);
            print('$workout has been added');
            callback(workoutDateApi);
          } else {
            print('No exercise selected.');
          }
        });
      },
    );
  }
}

class WorkoutListModal {
  static Future<Workout> showListModal(
      BuildContext context, CreateWorkoutDateViewModel workoutDateApi) {
    return showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        builder: (BuildContext context) {
          workoutDateApi.populateWorkoutsList();
          return workoutDateApi.isLoading
              ? Container(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  height: 250,
                  child: ListView.builder(
                    itemCount: workoutDateApi.workouts.length,
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
                            workoutDateApi.workouts[index].name,
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.white),
                          ),
                          onTap: () {
                            Navigator.of(context)
                                .pop(workoutDateApi.workouts[index]);
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

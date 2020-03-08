import 'package:flutter/material.dart';
import 'package:strength_project/core/global.dart';
import 'package:strength_project/core/models/workout_exercise.dart';
import 'package:strength_project/core/models/workout_set.dart';
import 'package:strength_project/core/viewmodels/workout_viewmodel.dart';
import 'package:strength_project/ui/pages/workout_view/widgets/addWorkoutSet.dart';

class WorkoutExerciseCard extends StatelessWidget {
  final int workoutIndex;
  final int exerciseIndex;
  final WorkoutExercise exercise;
  final CreateWorkoutViewModel workoutApi;
  final Function callback;
  WorkoutExerciseCard(
      {this.workoutIndex,
      this.exerciseIndex,
      this.exercise,
      this.workoutApi,
      this.callback});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: 10, left: 7, right: 7),
      child: Dismissible(
        background: Container(color: Colors.red),
        key: Key(exercise.name),
        onDismissed: (direction) {
          String eName = exercise.name;
          workoutApi.removeWorkoutExercise(exerciseIndex);
          Scaffold.of(context).showSnackBar(
              SnackBar(content: Text("$eName removed from workout list")));
        },
        child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    exercise.name,
                    textAlign: TextAlign.left,
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 30,
                    child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: _buildSetsList(context, exercise.workoutSets,
                            exerciseIndex, callback)),
                  ),
                ])),
      ),
    );
  }

  List<Widget> _buildSetsList(BuildContext context,
      List<WorkoutSet> workoutSets, int exerciseIndex, Function callback) {
    List<Widget> setsList = [];
    if (workoutSets != null) {
      for (var i = 0; i < workoutSets.length; i++) {
        final WorkoutSet workoutSet = workoutSets[i];

        setsList.add(GestureDetector(
          key: Key('workoutSet$i'),
          onTap: () => {
            workoutApi.removeWorkoutSet(exerciseIndex, i),
            callback(workoutApi),
            print('Removed WorkoutSet Chip')
          },
          child: Chip(
            label: Text('${workoutSet.reps} x ${workoutSet.weight}'),
            backgroundColor: blueTheme,
            labelStyle: TextStyle(color: Colors.white, fontSize: 12.0),
          ),
        ));

        setsList.add(SizedBox(
          width: 8,
        ));
      }

      setsList.add(AddWorkoutSet(
          workoutApi: workoutApi,
          workoutIndex: workoutIndex,
          exerciseIndex: exerciseIndex,
          callback: callback,
          key: Key('addWorkoutSet')));
      return setsList;
    } else {
      setsList.add(Center(
          child: AddWorkoutSet(
              workoutApi: workoutApi,
              workoutIndex: workoutIndex,
              exerciseIndex: exerciseIndex,
              callback: callback,
              key: Key('addWorkoutSet'))));
      return setsList;
    }
  }
}

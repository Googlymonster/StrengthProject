import 'package:flutter/material.dart';
import 'package:strength_project/core/global.dart';
import 'package:strength_project/core/viewmodels/workout_viewmodel.dart';
import 'package:strength_project/ui/pages/workout_view/widgets/counterButton.dart';

class AddWorkoutSet extends StatefulWidget {
  final CreateWorkoutViewModel workoutApi;
  final int workoutIndex;
  final int exerciseIndex;
  final Function callback;
  AddWorkoutSet(
      {this.workoutIndex,
      this.exerciseIndex,
      Key key,
      this.workoutApi,
      this.callback})
      : super(key: key);
  @override
  _AddWorkoutSetState createState() => _AddWorkoutSetState();
}

class _AddWorkoutSetState extends State<AddWorkoutSet> {
  int reps;
  int weight;
  CreateWorkoutViewModel workoutApi;
  Function callback;

  @override
  void initState() {
    super.initState();
    callback = widget.callback;
    workoutApi = widget.workoutApi;
    reps = 5;
    weight = 135;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: Key('addWorkoutBtn'),
      child: Icon(
        Icons.add_circle,
        color: blueTheme,
        size: 30,
      ),
      borderRadius: BorderRadius.circular(50),
      onTap: () {
        showModal(context).then((update) {
          if (update != null && update) {
            workoutApi.addWorkoutSet(
                widget.workoutIndex, widget.exerciseIndex, reps, weight);
            callback(workoutApi);
          }
        });
      },
    );
  }

  Future<dynamic> showModal(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 250,
          child: Column(
            children: <Widget>[
              SizedBox(height: 15.0),
              Counter(
                startingValue: 5,
                onChanged: (value) {
                  setState(() {
                    reps = value;
                  });
                },
              ),
              SizedBox(height: 20.0),
              Counter(
                startingValue: 135,
                increment: 5,
                onChanged: (value) {
                  setState(() {
                    weight = value;
                  });
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                key: Key('addSetButton'),
                color: blueTheme,
                textColor: Colors.white,
                child: Text('Add Set'),
                onPressed: () => Navigator.pop(context, true),
              )
            ],
          ),
        );
      },
    );
  }
}

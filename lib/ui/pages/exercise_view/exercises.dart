import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:strength_project/ui/pages/exercise_view/exercise_form.dart';
import 'package:strength_project/core/viewmodels/exercise_viewmodel.dart';
import 'package:strength_project/core/models/exercise.dart';

// This page will show the list of exercises available for
// users to select from to create workouts from. Users will
// need to navigate to the form page to create exercises.
class Exercises extends StatefulWidget {
  @override
  ExercisesState createState() => ExercisesState();
}

class ExercisesState extends State<Exercises> {
  CreateExerciseViewModel _exerciseApi = CreateExerciseViewModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GradientAppBar(
          backgroundColorStart: Colors.cyan,
          backgroundColorEnd: Colors.indigo,
          title: Text('My Exercises'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add_circle_outline),
              color: Colors.white,
              tooltip: 'Add New Exercise',
              onPressed: _createExerciseForm,
            ),
          ],
        ),
        body: _buildList());
  }

  // Function to send to exercise form page
  void _createExerciseForm() {
    Navigator.of(context).push(MaterialPageRoute(
        fullscreenDialog: true,
        builder: (BuildContext context) {
          return Scaffold(
            appBar: GradientAppBar(
              title: Text('Add New Exercise'),
              backgroundColorStart: Colors.cyan,
              backgroundColorEnd: Colors.indigo,
            ),
            body: ExerciseForm(),
          );
        }));
  }

  // Fuction that uses the information from the exercise to populate the
  // exercise form and update
  void _updateExerciseForm(Exercise exercise) {
    Navigator.of(context).push(MaterialPageRoute(
        fullscreenDialog: true,
        builder: (BuildContext context) {
          return Scaffold(
            appBar: GradientAppBar(
              title: Text('Update Exercise'),
              backgroundColorStart: Colors.cyan,
              backgroundColorEnd: Colors.indigo,
            ),
            body: ExerciseForm(
              exercise: exercise,
            ),
          );
        }));
  }

  // Builds the list view for the exercises available to the user
  Widget _buildList() {
    return StreamBuilder<QuerySnapshot>(
        stream: _exerciseApi.fetchExercisesAsStream(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              return ListView.separated(
                  separatorBuilder: (context, index) =>
                      Divider(color: Colors.black),
                  padding: EdgeInsets.all(8),
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot document =
                        snapshot.data.documents[index];
                    Exercise exercise = Exercise.fromMap(document.data, document.documentID);
                    return Slidable(
                      actionPane: SlidableDrawerActionPane(),
                      child: ListTile(
                        title: Text(exercise.name),
                        contentPadding: EdgeInsets.all(10.0),
                        trailing: Icon(Icons.arrow_left),
                      ),
                      secondaryActions: <Widget>[
                        IconSlideAction(
                          caption: 'Delete',
                          color: Colors.red[400],
                          icon: Icons.delete,
                          onTap: () {
                            _exerciseApi.removeExercise(exercise.uid);
                          },
                        ),
                        IconSlideAction(
                          caption: 'Edit',
                          color: Colors.indigo[400],
                          icon: Icons.edit,
                          onTap: () {
                            _updateExerciseForm(exercise);
                          },
                        ),
                      ],
                    );
                  });
          }
        });
  }
}

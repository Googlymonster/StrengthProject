import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:strength_project/ui/pages/workout_view/workout_form.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:strength_project/core/viewmodels/workout_viewmodel.dart';

class Workouts extends StatelessWidget {
  CreateWorkoutViewModel _workoutApi = CreateWorkoutViewModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        backgroundColorStart: Colors.cyan,
        backgroundColorEnd: Colors.indigo,
        title: Text("Workout List"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add_circle_outline),
              tooltip: 'Create New Workout',
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (BuildContext context) {
                      return Scaffold(
                        appBar: GradientAppBar(
                          title: Text('Add New Workout'),
                          backgroundColorStart: Colors.cyan,
                          backgroundColorEnd: Colors.indigo,
                        ),
                        body: WorkoutsForm(workoutApi: _workoutApi),
                      );
                    }));
              }),
        ],
      ),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    return StreamBuilder<QuerySnapshot>(
        stream: _workoutApi.fetchWorkoutsAsStream(),
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

                    return Slidable(
                      actionPane: SlidableDrawerActionPane(),
                      child: ExpansionTile(
                        key: PageStorageKey(document.documentID),
                        title: Text(document.data['name']),
                        trailing: Icon(Icons.arrow_drop_down),
                        children: _workoutListTile(document),
                      ),
                      secondaryActions: <Widget>[
                        IconSlideAction(
                          caption: 'Delete',
                          color: Colors.red[400],
                          icon: Icons.delete,
                          onTap: () {
                            document.reference.delete();
                          },
                        ),
                        IconSlideAction(
                          caption: 'Edit',
                          color: Colors.indigo[400],
                          icon: Icons.edit,
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                fullscreenDialog: true,
                                builder: (BuildContext context) {
                                  return Scaffold(
                                    appBar: GradientAppBar(
                                      title: Text('Add New Workout'),
                                      backgroundColorStart: Colors.cyan,
                                      backgroundColorEnd: Colors.indigo,
                                    ),
                                    body: WorkoutsForm(
                                      workoutApi: _workoutApi,
                                      document: document,
                                    ),
                                  );
                                }));
                          },
                        ),
                      ],
                    );
                  });
          }
        });
  }

  _workoutListTile(DocumentSnapshot document) {
    List<Widget> contentList = [];
    if (document.data['workoutExercises'] == null ||
        document.data['workoutExercises'].isEmpty) {
      contentList.add(ListTile(
        title: Text('No exercises in this workout.',
            style: TextStyle(fontSize: 18.0, color: Colors.black54)),
        contentPadding: EdgeInsets.fromLTRB(30, 0, 10, 0),
      ));
    } else {
      for (var item in document.data['workoutExercises']) {
        contentList.add(Divider(
          color: Colors.black26,
        ));
        contentList.add(ListTile(
          title: Text(item['name'],
              style: TextStyle(fontSize: 18.0, color: Colors.black54)),
          contentPadding: EdgeInsets.fromLTRB(50, 0, 10, 0),
        ));
      }
    }
    return contentList;
  }
}

// class Workouts extends StatefulWidget {
//   @override
//   _WorkoutsState createState() => _WorkoutsState();
// }

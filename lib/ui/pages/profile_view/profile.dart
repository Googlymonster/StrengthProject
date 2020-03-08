import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:strength_project/ui/widgets/myCustomDrawer.dart';
import 'package:strength_project/core/services/auth.dart';
import 'package:provider/provider.dart';
// import 'package:strength_project/core/viewmodels/CRUDModel.dart';

class Profile extends StatelessWidget {
  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthService>(context, listen: false);
      await auth.signOut();
      print('User Signed Out from Home Page');
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: MyCustomDrawer(),
      appBar: GradientAppBar(
        title: Text('My Profile'),
        backgroundColorStart: Colors.cyan,
        backgroundColorEnd: Colors.indigo,
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Logout',
              style: TextStyle(fontSize: 17.0, color: Colors.white),
            ),
            onPressed: () => _signOut(context),
          )
        ],
      ),
      body: Center(
        child: Container(
          child: Center(
            child: Text("Profile Page"),
            // onPressed: () {
            //   print(_auth.status);
            // },
          ),
          // child: _profile(profile),
        ),
      ),
    );
  }

  // Widget _profile(profile) {
  //   return StreamBuilder<QuerySnapshot>(
  //       stream: profile.fetchUserAsStream(),
  //       builder: (context, snapshot) {
  //         final DocumentSnapshot document = snapshot.data.documents[0];
  //         final String firstName = document['firstName'];
  //         return Container(
  //           child: Center(
  //             child: Text("$firstName"),
  //           ),
  //         );
  //       });
  // }
}

// class Profile extends StatefulWidget {
//   @override
//   _ProfileState createState() => _ProfileState();
// }

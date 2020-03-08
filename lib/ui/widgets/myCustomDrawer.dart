import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:strength_project/core/global.dart';
import 'package:strength_project/core/services/auth.dart';

/// This Custom Drawer has a dynamic list tile that takes
/// in properties. The custom list tile class can be found below it.
/// Custom list tile that has a constructor that takes in the icon, text, and function
/// onTap.

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function onTap;

  CustomListTile(this.icon, this.text, this.onTap);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.indigo.shade400))),
        child: InkWell(
          splashColor: Colors.orangeAccent,
          onTap: onTap,
          child: Container(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(icon),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                    ),
                    Text(
                      text,
                      style: TextStyle(fontSize: 16.0),
                    )
                  ],
                ),
                Icon(Icons.arrow_right)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyCustomDrawer extends StatefulWidget {
  @override
  _MyCustomDrawerState createState() => _MyCustomDrawerState();
}

class _MyCustomDrawerState extends State<MyCustomDrawer>
    with AutomaticKeepAliveClientMixin {
  // AuthService _auth;
  // @override
  // void initState() {
  //   _auth = AuthService();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = Provider.of<AuthService>(context);
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: <Color>[
              Colors.cyan,
              Colors.indigo,
            ])),
            child: Container(
              child: Column(
                children: <Widget>[
                  Material(
                    borderRadius: BorderRadius.all(Radius.circular(70.0)),
                    elevation: 10,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(200, 200, 200, 0.5),
                        border: Border.all(
                          color: Colors.black12,
                          width: 1,
                        ),
                      ),
                      child: FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        padding: EdgeInsets.all(0.0),
                        child: Image.asset('assets/images/user_icon.png'),
                      ),
                    ),
                  ),
                  Text(
                    'Strength Project',
                    style: TextStyle(color: Colors.white, fontSize: 25.0),
                  )
                ],
              ),
            ),
          ),
          // CustomListTile(
          //     Icons.person,
          //     'Profile',
          //     () => {
          //           Navigator.of(context).pop(),
          //           Navigator.of(context).pushNamed(profileRoute)
          //         }),
          CustomListTile(
              Icons.calendar_today,
              'Schedule Workouts',
              () => {
                    Navigator.of(context).pop(),
                    Navigator.of(context).pushNamed(workoutDateRoute)
                  }),
          CustomListTile(
              Icons.category,
              'My Workouts',
              () => {
                    Navigator.of(context).pop(),
                    Navigator.of(context).pushNamed(workoutRoute)
                  }),
          CustomListTile(
              Icons.fitness_center,
              'My Exercises',
              () => {
                    Navigator.of(context).pop(),
                    Navigator.of(context).pushNamed(exerciseRoute)
                  }),
          // CustomListTile(
          //     Icons.settings,
          //     'Settings',
          //     () => {
          //           Navigator.of(context).pop(),
          //           Navigator.of(context).pushNamed(settingsRoute)
          //         }),
          CustomListTile(
              Icons.exit_to_app,
              'Logout',
              () => {
                    Navigator.of(context).pop(),
                    _auth.signOut(),
                    print('User Signed Out from Drawer'),
                    print(_auth.status),
                  }),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

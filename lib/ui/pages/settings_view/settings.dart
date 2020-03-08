import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        title: Text('Settings'),
        backgroundColorStart: Colors.cyan,
        backgroundColorEnd: Colors.indigo,
      ),
      body: Container(
        child: Center(
          child: Text('Settings Page Coming Soon ....'),
        ),
      ),
    );
  }
}

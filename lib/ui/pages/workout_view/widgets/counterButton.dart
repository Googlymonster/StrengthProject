import 'package:flutter/material.dart';
import 'package:strength_project/core/global.dart';

class Counter extends StatefulWidget {
  final Function onChanged;
  final int increment;
  final int startingValue;

  Counter({
    this.startingValue = 0,
    this.onChanged,
    this.increment = 1,
  });

  @override
  State<StatefulWidget> createState() {
    return _CounterState();
  }
}

class _CounterState extends State<Counter> {
  int value;

  void initState() {
    super.initState();
    value = widget.startingValue;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.remove_circle_outline,
            color: blueTheme,
          ),
          onPressed: _subtract,
        ),
        Text(
          value.toString(),
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.add_circle_outline,
            color: blueTheme,
          ),
          onPressed: _add,
        ),
      ],
    );
  }

  void _subtract() {
    // extra logic for preventing negative values
    int newValue = value - widget.increment;
    if (newValue < 0) {
      newValue = 0;
    }
    setState(() {
      value = newValue;
      widget.onChanged(value);
    });
  }

  void _add() {
    setState(() {
      value = value + widget.increment;
      widget.onChanged(value);
    });
  }
}

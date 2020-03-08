import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:strength_project/core/models/workout.dart';
import 'package:strength_project/core/viewmodels/workoutDate_viewmodel.dart';
import 'package:strength_project/ui/pages/calender_view/widgets/addWorkoutDateButton.dart';
import 'package:table_calendar/table_calendar.dart';

class WorkoutsDate extends StatefulWidget {
  final int year;
  final int month;
  final int day;
  WorkoutsDate({Key key, this.year, this.month, this.day}) : super(key: key);
  _WorkoutsDateState createState() => _WorkoutsDateState();
}

class _WorkoutsDateState extends State<WorkoutsDate>
    with TickerProviderStateMixin {
  CalendarController _calendarController;
  AnimationController _animationController;
  CreateWorkoutDateViewModel _workoutDateApi = CreateWorkoutDateViewModel();
  Map<DateTime, List> _events;
  List _selectedEvents;
  DateTime _selectedDay;

  @override
  void initState() {
    super.initState();
    final _selectedDay = DateTime.now();
    CreateWorkoutDateViewModel _workoutDateApi = CreateWorkoutDateViewModel();
    // _events = _workoutDateApi.fetchWorkoutDates();
    _events = {
      _selectedDay.subtract(Duration(days: 30)): [
        'Event A0',
        'Event B0',
        'Event C0'
      ],
      _selectedDay.subtract(Duration(days: 27)): ['Event A1'],
      _selectedDay.subtract(Duration(days: 20)): [
        'Event A2',
        'Event B2',
        'Event C2',
        'Event D2'
      ],
      _selectedDay.subtract(Duration(days: 16)): ['Event A3', 'Event B3'],
      _selectedDay.subtract(Duration(days: 10)): [
        'Event A4',
        'Event B4',
        'Event C4'
      ],
      _selectedDay.subtract(Duration(days: 4)): [
        'Event A5',
        'Event B5',
        'Event C5'
      ],
      _selectedDay.subtract(Duration(days: 2)): ['Event A6', 'Event B6'],
      _selectedDay: ['Event A7', 'Event B7', 'Event C7', 'Event D7'],
      _selectedDay.add(Duration(days: 1)): [
        'Event A8',
        'Event B8',
        'Event C8',
        'Event D8'
      ],
      _selectedDay.add(Duration(days: 3)):
          Set.from(['Event A9', 'Event A9', 'Event B9']).toList(),
      _selectedDay.add(Duration(days: 7)): [
        'Event A10',
        'Event B10',
        'Event C10'
      ],
      _selectedDay.add(Duration(days: 11)): ['Event A11', 'Event B11'],
      _selectedDay.add(Duration(days: 17)): [
        'Event A12',
        'Event B12',
        'Event C12',
        'Event D12'
      ],
      _selectedDay.add(Duration(days: 22)): ['Event A13', 'Event B13'],
      _selectedDay.add(Duration(days: 26)): [
        'Event A14',
        'Event B14',
        'Event C14'
      ],
    };
    _selectedEvents = _events[_selectedDay] ?? [];
    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events) {
    setState(() {
      _selectedDay = day;
      _selectedEvents = events;
    });
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        backgroundColorStart: Colors.cyan,
        backgroundColorEnd: Colors.indigo,
        title: Text("Workout List"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            _calenderView(),
            Expanded(
              child: _workoutEventViewer(),
              flex: 4,
            ),
            AddWorkoutDateButton(
              key: Key('addWorkoutDateWidget'),
              showModal: WorkoutListModal.showListModal,
              workoutDateApi: _workoutDateApi,
              callback: refreshCallback,
            ),
            Expanded(
              flex: 1,
              child: SizedBox(
                height: 12.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _calenderView() {
    return Container(
      child: TableCalendar(
        locale: 'en_US',
        calendarController: _calendarController,
        events: _events,
        formatAnimation: FormatAnimation.slide,
        builders: CalendarBuilders(
          selectedDayBuilder: (context, date, _) {
            return FadeTransition(
              opacity:
                  Tween(begin: 0.0, end: 1.0).animate(_animationController),
              child: Container(
                margin: const EdgeInsets.all(4.0),
                padding: const EdgeInsets.only(top: 5.0, left: 6.0),
                color: Colors.deepOrange[300],
                width: 100,
                height: 100,
                child: Text(
                  '${date.day}',
                  style: TextStyle().copyWith(fontSize: 16.0),
                ),
              ),
            );
          },
          todayDayBuilder: (context, date, _) {
            return Container(
              margin: const EdgeInsets.all(4.0),
              padding: const EdgeInsets.only(top: 5.0, left: 6.0),
              color: Colors.amber[400],
              width: 100,
              height: 100,
              child: Text(
                '${date.day}',
                style: TextStyle().copyWith(fontSize: 16.0),
              ),
            );
          },
          markersBuilder: (context, date, events, _) {
            final children = <Widget>[];

            if (events.isNotEmpty) {
              children.add(
                Positioned(
                  right: 1,
                  bottom: 1,
                  child: _buildEventsMarker(date, events),
                ),
              );
            }

            return children;
          },
        ),
        onDaySelected: (date, events) {
          _onDaySelected(date, events);
          _animationController.forward(from: 0.0);
        },
        onVisibleDaysChanged: _onVisibleDaysChanged,
      ),
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _calendarController.isSelected(date)
            ? Colors.brown[500]
            : _calendarController.isToday(date)
                ? Colors.brown[300]
                : Colors.blue[400],
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  Widget _workoutEventViewer() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _selectedEvents.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          margin: EdgeInsets.only(top: 10, left: 7, right: 7),
          color: Colors.blue[400],
          child: Dismissible(
            background: Container(color: Colors.red),
            key: Key(_selectedEvents[index]),
            onDismissed: (direction) {
              String eName = _selectedEvents[index].toString();
              setState(() {
                _selectedEvents.removeAt(index);
              });
              Scaffold.of(context).showSnackBar(
                  SnackBar(content: Text("$eName removed from calender.")));
            },
            child: Container(
              child: ListTile(
                dense: true,
                title: Text(
                  _selectedEvents[index].toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.white),
                ),
                onTap: () {},
              ),
            ),
          ),
        );
      },
    );
  }

  void refreshCallback() {}

  void _workoutDateCalenderSubmission() {}
}

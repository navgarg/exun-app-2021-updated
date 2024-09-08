import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:exun_app_21/constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:http/http.dart';


class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

//todo: check why update occurs after 2nd click
List<Schedule> _schedules = <Schedule>[];
DateTime start = DateTime(2022, 1, 14);

class _ScheduleScreenState extends State<ScheduleScreen> {

  final _firestore = FirebaseFirestore.instance;


  @override
  Widget build(BuildContext context) {
    if(start.isBefore(DateTime.now())){
      start = DateTime.now();
    }
    return FutureBuilder(
        future: fetchSchedule(),
        builder: (ctx, snapshot) => snapshot.connectionState == ConnectionState.waiting
            ? Center(
          child: CircularProgressIndicator(),
        )
            : RefreshIndicator(
          onRefresh: () {
              return fetchSchedule();
                 }, child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                     child: FutureBuilder(
                       future: fetchSchedule(),
                       builder: (BuildContext context, AsyncSnapshot snapshot) {
                         if (snapshot.data != null) {
                           // return SafeArea(
                           //   child:
                             return Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                      Padding(
                                         padding: EdgeInsets.symmetric(horizontal: 14.0),
                                         child:  Text(
                                             "Upcoming:",
                                             style: TextStyle(
                                               fontSize: 17.0,
                                               fontWeight: FontWeight.bold,
                                               color: KColors.primaryText,
                                             )
                                       ),
                                       ),
                                     Flexible(child:
                                     SfCalendar(
                                     onTap: calendarTapped,
                                     view: CalendarView.schedule,
                                     appointmentBuilder: appointmentBuilder,
                                     firstDayOfWeek: 5,
                                     // showWeekNumber: true,
                                       weekNumberStyle:WeekNumberStyle(
                                     // backgroundColor: Colors.blue,
                                     textStyle: TextStyle(fontSize: 0)
                         ),
                                     headerStyle: CalendarHeaderStyle(
                                         textStyle: TextStyle(fontSize: 0)
                                     ),
                                     // initialDisplayDate: DateTime(2022, 1, 14),
                                     minDate: start,
                                     scheduleViewSettings: ScheduleViewSettings(
                                       // appointmentTextStyle: TextStyle(
                                       //     fontWeight: FontWeight.w700,
                                       //     height: 1.5,
                                       //     color: Colors.black
                                       // ),
                                       appointmentItemHeight: 70,
                                       hideEmptyScheduleWeek: true,
                                     ),
                                     dataSource: ScheduleDataSource(snapshot.data),
                                   )
                                     )
                                   ]
                             // )
                           );
                         }

                         else {
                           return Container(
                             child: Center(
                               child: Text(''),
                             ),
                           );
                         }
                         },
                     ),
        ),
        ),
    );
  }

  Widget appointmentBuilder(BuildContext context,
      CalendarAppointmentDetails calendarAppointmentDetails) {
    final Schedule appointment =
        calendarAppointmentDetails.appointments.first;
    return ListTile(
      // leading: Image.asset('assets/circuit.png'),
      title: Text(
      appointment.eventName,
        style: const TextStyle(
          fontSize: 16,
          color: KColors.primaryText,
        ),),
      subtitle: Text(
        DateFormat.jm().format(appointment.date).toString(),
        style: const TextStyle(
          color: KColors.bodyText,
          fontSize: 13.0,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      isThreeLine: true,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: KColors.border, width: 1),
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }

  void calendarTapped(CalendarTapDetails details) {
    if (details.targetElement == CalendarElement.appointment ||
        details.targetElement == CalendarElement.agenda) {
      final Schedule appointmentDetails = details.appointments![0];
     String _subject = appointmentDetails.eventName;
     String _content = appointmentDetails.content;
     String _event = appointmentDetails.event;
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Container(child: new Text('$_subject')),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                // height: 155,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                            child: new Text(
                              '$_content',
                              // overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                         )
                      ],
                    ),
                  ],
                ),
              ),
            ]
              ),
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    new TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        // new FlatButton(
                        //     onPressed: () {
                        //       Navigator.of(context).pop();
                        //     },
                        child: new Text('Close')),
                    new TextButton(
                        onPressed: () async {
                          participate(_event);
                        },
                        // new FlatButton(
                        //     onPressed: () {
                        //       Navigator.of(context).pop();
                        //     },
                        child: new Text('Participate'))
                  ],
                )
              ],
            );
          });
    }
  }

  Future<void> participate(String event) async {

    var currentUser = FirebaseAuth.instance.currentUser;
    final snapshot = await _firestore.collection("users").doc(currentUser?.uid).get();
    print("snapshot");
    // print(currentUser?.uid);
    print(snapshot.data());
    List<dynamic>? events = snapshot.data()?["events"].toList();

    if (events!.contains(event)){
      Fluttertoast.showToast(msg: "You have already participated in this event");
    }
    else{
      events.add(event);
      Fluttertoast.showToast(msg: "Successfully added event!");
    }
    _firestore.collection("users").doc(currentUser?.uid)
        .set({'events': events,
      'likedTalks': snapshot.data()?["likedTalks"],
      'name': snapshot.data()?["name"],
      'email': snapshot.data()?["email"],
      'role': snapshot.data()?["role"],
    })
        .then((value) => print("Event Added"))
        .catchError((error) => print("Failed to add event: $error"));


    Navigator.of(context).pop();
  }
  }


  Future<List<Schedule>> fetchSchedule() async {
    print("fetch");
      try {
        var uri = Uri.parse(getScheduleUrl);
        print(uri);
        var value = await get(uri);
        print("value");
        print(value);
        print("value");
        var parsed = json.decode(value.body);
        print(parsed);
        _schedules = parsed['rows']
            .map<Schedule>((json) => Schedule.fromJson(json))
            .toList();
        _schedules.sort((a, b) {
          Schedule x = a;
          Schedule y = b;
          return x.date.compareTo(y.date);
        });
        _schedules.removeWhere((element) => element.date.isBefore(DateTime.now()));
        // print(_schedules.length);
        // print(_schedules[0].eventName);
        start = _schedules[0].date;
        // print("start");
        // print(start);
      } catch (e) {
        _schedules = [];
        print("error");
        print(e);
        print("error");
      }
    return _schedules;
  }

class ScheduleDataSource extends CalendarDataSource {
  ScheduleDataSource(List<Schedule> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getSchedule(index).date;
  }

  @override
  DateTime getEndTime(int index) {
    return _getSchedule(index).date.add(const Duration(hours: 1));
  }

  @override
  String getSubject(int index) {
    return _getSchedule(index).eventName;
  }

  @override
  Color getColor(int index){
    return Color(0xFFffffff);
  }

  String getContent(int index) {
    return _getSchedule(index).content;
  }

  Schedule _getSchedule(int index) {
    final dynamic schedule = appointments![index];
    late final Schedule scheduleData;
    if (schedule is Schedule) {
      scheduleData = schedule;
    }

    return scheduleData;
  }
}

class Schedule {
  String eventName;
  DateTime date;
  String content;
  String event;

  Schedule(this.eventName, this.content, this.event, {required this.date});

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      json['name'],
      json['information'],
      json['event'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() => {
    'name': eventName,
    'information': content,
    'date': date.toString(),
    'event': event,
  };

}



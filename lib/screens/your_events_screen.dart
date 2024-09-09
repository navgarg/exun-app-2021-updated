import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exun_app_21/screens/schedule_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

import '../constants.dart';

class YourEventsScreen extends StatefulWidget{
  const YourEventsScreen({Key? key}) : super(key: key);

  @override
  _YourEventsScreenState createState() => _YourEventsScreenState();
}

class _YourEventsScreenState extends State<YourEventsScreen>{

  final _firestore = FirebaseFirestore.instance;
  var currentUser = FirebaseAuth.instance.currentUser;
  List<Schedule> _eventsList = [];



  Future<void> getEvents() async {

    final snapshot = await _firestore.collection("users").doc(currentUser?.uid).get();
    print("snapshot");
    print(snapshot.data());
    List<dynamic>? events = snapshot.data()?["events"];
    List<Schedule> _schedules;

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
      _schedules.removeWhere((element) =>
          element.date.isBefore(DateTime.now()));
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
    List<String> eventTitles = [];
    for (var schedule in _schedules){
      // print(schedule.eventName);
      if(events!.contains(schedule.event) && !eventTitles.contains(schedule.eventName)){
        // print("in if");
        _eventsList.add(schedule);
        eventTitles.add(schedule.eventName);
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getEvents(),
        builder: (ctx, snapshot) =>
        snapshot.connectionState == ConnectionState.waiting
        ? Center(
          child: CircularProgressIndicator(),
        )
            : RefreshIndicator(
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
              child: ListView.builder(
                shrinkWrap: true,
                  itemCount: _eventsList.length,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index){

                    Schedule sch = _eventsList[index];
                    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(sch.date);
                    String cont = sch.content;
                    return Padding(padding: EdgeInsets.symmetric(horizontal: 38.0, vertical: 10),
                    child: ListTile(
                      leading: Image.asset("assets/circuit.png"),
                      title: Text(sch.eventName,
                        style: const TextStyle(
                          fontSize: 16,
                          color: KColors.primaryText,
                        ),),
                      subtitle: Text(
                        '$formattedDate\n$cont',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: KColors.bodyText,
                          fontSize: 13.0,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            color: KColors.border, width: 1),
                        borderRadius: BorderRadius.circular(8.0),
                      ),

                    ),);

                  }
              ),
            ),
            onRefresh: () {
              return getEvents();
            })
    );
  }

}
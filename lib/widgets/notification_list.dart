import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exun_app_21/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'notification_tile.dart';

class NotificationList extends StatefulWidget {
  const NotificationList({Key? key}) : super(key: key);

  @override
  _NotificationListState createState() => _NotificationListState();
}

class Notification {
  String title;
  String subtitle;
  String message;
  DateTime createdAt;
  String event;

  Notification(
      {required this.title, required this.message, required this.subtitle, required this.createdAt, required this.event});

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      title: json['title'],
      subtitle: json['subtitle'],
      message: json['message'],
      createdAt: DateTime.parse(json['created_at']),
      event: json["event"],
    );
  }

  factory Notification.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return Notification(
      title: data["title"],
      subtitle: data["subtitle"],
      message: data["message"],
      createdAt: data["created_at"].toDate(),
      event: data["event"]

    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'subtitle': subtitle,
        'message': message,
        'created_at': createdAt.toString(),
        'event': event,
      };
}

class _NotificationListState extends State<NotificationList> {
  List<Notification> _notifications = [];
  final _firestore = FirebaseFirestore.instance;
  bool _notifLoaded = false;

  @override
  void initState() {
    print("is this called");
    super.initState();
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print("is this called?");
      _notifLoaded = false;
      fetchNotifs();
    });
  }

   Future<void> fetchNotifs() async {
    // await openBox();
     print("notif loaded?");
    print(_notifLoaded);
    if (!_notifLoaded) {
      // try {
        final snapshot = await _firestore.collection("notifications").get();
        print("snapshot");
        print(snapshot);
        print(snapshot.docs);
        _notifications = snapshot.docs.map((e) => Notification.fromSnapshot(e)).toList();
        print(_notifications);
        _notifications.sort((a, b) {
          Notification x = a;
          Notification y = b;
          return y.createdAt.compareTo(x.createdAt);
        });
       var currentUser = FirebaseAuth.instance.currentUser;


        final snap = await _firestore.collection("users").doc(currentUser?.uid).get();
        print("snapshot");
        // print(currentUser?.uid);
        print(snap.data());
        List<dynamic>? events = snap.data()?["events"].toList();
        print(_notifications[0].event);
        print(events);
        for (var i = 0;  i<_notifications.length; i++){
          print(_notifications[i].event);
          if(!events!.contains(_notifications[i].event)){
            print("in if");
            var event = _notifications[i].event;
            print(event);
            _notifications.removeWhere((e) => e.event == event);
          }
          else{
            print(_notifications[i].event);
          }

        }
        print(_notifications[0].event);
        // await putData(_notifications);
        // filteredNotifs = _notifications;
        _notifLoaded = true;
        print(_notifLoaded);
        print(_notifications);
        // }
        setState(() {});
      // } catch (e) {
      //   _notifications = [];
      //   print("error");
      //   print(e);
      //   print("error");
      //   for (var j in box.toMap().values.toList()) {
      //     Map<String, dynamic> x = new Map.from(j);
      //     notifs.add(Notification.fromJson(x));
      //   }
      //   // filteredNotifs = notifs;
      //   _notifLoaded = true;
      //
      //   setState(() {});
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference notifs_ref = FirebaseFirestore.instance.collection('notifications');

    return FutureBuilder(
      // future: fetchNotifs(),
      future: notifs_ref.get(),
      builder: (ctx, snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : RefreshIndicator(
                  onRefresh: () {
                    _notifLoaded = false;
                    return fetchNotifs();
                  },
                  child: ListView.builder(
                    itemCount: _notifications.length,
                    itemBuilder: (BuildContext context, int index) {
                      Notification notif = _notifications[index];
                      DateTime y = DateTime.now();
                      int ago = y.difference(notif.createdAt).inHours;
                      String time;
                      if (ago>=24){
                        ago=(ago~/24);
                        if (ago==1){
                          time = "$ago day ago";
                        }
                        else{
                          time = "$ago days ago";
                        }
                      }
                      else{
                        time = "$ago hrs ago";
                      }
                      return NotificationTile(
                        heading: notif.title,
                        time: time,
                        content: notif.message,
                        subtitle: notif.subtitle,
                      );
                    },
                  ),
                ),
    );
  }
}

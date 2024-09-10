import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exun_app_21/constants.dart';
import 'package:exun_app_21/support_screens/add_notif.dart';
import 'package:exun_app_21/widgets/notification_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  String _role = "member";
  var currentUser = FirebaseAuth.instance.currentUser;
  final _firestore = FirebaseFirestore.instance;

  Future<void> getRole () async {

    final snapshot = await _firestore.collection("users").doc(currentUser?.uid).get();
    print("snapshot");
    // print(currentUser?.uid);
    print(snapshot.data());
    _role = snapshot.data()!["role"].toString();
  }



  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
        future: getRole(),
        builder: (ctx, snapshot){
          return Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 34.0),
                  child: Text(
                    "Welcome!",
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                      color: KColors.primaryText,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Expanded(child: NotificationList()),
              ],
            ),
            floatingActionButton:
            _role == "admin" 
                ? FloatingActionButton(
                onPressed: () => Navigator.of(context).push(
                    new MaterialPageRoute(builder: (BuildContext context) => new AddNotifScreen())),
              child: Icon(Icons.add),
            )
                : Container()
          );
        });
  }
}

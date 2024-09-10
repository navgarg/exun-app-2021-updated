import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exun_app_21/main_screens/signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {

  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  String _role = "member";

  var currentUser = FirebaseAuth.instance.currentUser;
  final _firestore = FirebaseFirestore.instance;

  Future<void> getData() async {
    final snapshot = await _firestore.collection("users").doc(currentUser?.uid).get();
    print("snapshot");
    // print(currentUser?.uid);
    print(snapshot.data());
    _nameController.value = TextEditingValue(text: snapshot.data()?["name"]);
    _emailController.value = TextEditingValue(text: snapshot.data()?["email"]);
    _role = snapshot.data()!["role"].toString();
    // print(snapshot);
  }

      @override
      Widget build(BuildContext context) {
        return FutureBuilder(
            future: getData(),
            builder: (ctx, snapshot){
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image(image: AssetImage("assets/exun_logo.png")),
                              SizedBox(
                                height: 40.0,
                              ),
                              TextFormField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                    labelText: 'Email'
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              TextFormField(
                                controller: _nameController,
                                decoration: InputDecoration(
                                    labelText: 'Name'
                                ),
                              ),
                              SizedBox(
                                height: 80.0,
                              ),
                              ElevatedButton(
                                  onPressed: () async {
                                    await FirebaseAuth.instance.signOut();
                                    Navigator.of(context).push(
                                        new MaterialPageRoute(builder: (
                                            BuildContext context) => new LoginScreen()));
                                  },
                                  child: Text(
                                    "Sign Out",
                                    style: TextStyle(
                                      color: KColors.primaryText,
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                              ),
                              SizedBox(
                                height: 20.0,
                              ),

                              _role == "admin"
                                  ? ElevatedButton(
                                  onPressed: () async {
                                    await FirebaseAuth.instance.signOut();
                                    Navigator.of(context).push(
                                        new MaterialPageRoute(builder: (
                                            BuildContext context) => new SignInScreen(role: "admin")));
                                  },
                                  child: Text(
                                    "Add Admin",
                                    style: TextStyle(
                                      color: KColors.primaryText,
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                              )
                                  : Container(),
                            ]
                        ),
                      ),
                    )
              );
            });
      }



}
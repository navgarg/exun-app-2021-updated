import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {

  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();

  //todo: get data from firebase.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 50.0),
          child: Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                Image(image: AssetImage("assets/logo.png")),
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
                        new MaterialPageRoute(builder: (BuildContext context) => new LoginScreen()));

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
            ]
            ),
          ),
        )
    );
  }

}
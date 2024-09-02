import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exun_app_21/screens/tabs_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constants.dart';
import 'login_screen.dart';


class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>{

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _firestore = FirebaseFirestore.instance;


  Future<void> SignIn() async {
    try {
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      Fluttertoast.showToast(msg: "Signed in successfully!");
      final query = <String, String>{
        "email": _emailController.text,
        "name": _nameController.text,
        "role": "Member",
      };
      _firestore.collection("users").doc(FirebaseAuth.instance.currentUser?.uid).set(query).onError((e, _) => print("Error $e"));
      print('Signed in with email: ${userCredential.user?.email}');
      Navigator.of(context).push(
          new MaterialPageRoute(builder: (BuildContext context) => new TabsScreen()));
    } on FirebaseAuthException catch (e) {
      // Handle sign-in errors
      print('Sign-in error: $e');
      var message = "";
      if (e.code == 'invalid-password') {
        message = "Password must be atleast 6 characters";
      }
      if (e.code == 'invalid-email') {
        message = "Invalid email";
      }
      if (e.code == 'email-already-exists') {
        message = "This email is already registered.";
      }
      Fluttertoast.showToast(msg: "Error: $message");
    }
  }

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
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: 'Password'
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
                  height: 85.0,
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (_nameController.text.isEmpty){
                        Fluttertoast.showToast(msg: "Please enter name.");
                      }
                      else{
                        SignIn();
                      }
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        color: KColors.primaryText,
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                ),
                SizedBox(
                  height: 30.0,
                ),
                //todo: add button for signin with google
                // ElevatedButton(
                //     onPressed: (){},
                //     child: Text('Google',
                //       style: TextStyle(
                //         color: KColors.primaryText,
                //         fontSize: 17.0,
                //         fontWeight: FontWeight.bold,
                //       ),
                //     )
                // )
                SizedBox(
                  height: 50.0,
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).push(
                      new MaterialPageRoute(builder: (BuildContext context) => new LoginScreen())),
                  child: Text(
                    "Already a user? Log In.",
                    style: TextStyle(
                      color: KColors.primaryText,
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )

    );
  }
}
import 'package:exun_app_21/screens/schedule_screen.dart';
import 'package:exun_app_21/screens/signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constants.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>{

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: 'Password'
                  ),
                ),
                SizedBox(
                  height: 85.0,
                ),
                ElevatedButton(
                    onPressed: ()async {
                      try {
                        final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: _emailController.text,
                          password: _passwordController.text,
                        );
                        print('Signed in with email: ${userCredential.user?.email}');
                      } on FirebaseAuthException catch (e) {
                        print('Sign-in error: $e');
                        if (e.code == 'user-not-found') {
                          Fluttertoast.showToast(msg: "No user found for given email.");
                        } else if (e.code == 'wrong-password') {
                          Fluttertoast.showToast(msg: "Invalid password.");
                        }

                      }
                    },
                    child: Text(
                      'Login',
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
                        new MaterialPageRoute(builder: (BuildContext context) => new SignInScreen())),
                    child: Text(
                        "Not a user? Register.",
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
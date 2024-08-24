import 'package:exun_app_21/screens/schedule_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
                    } catch (e) {
                    // Handle sign-in errors
                    print('Sign-in error: $e');
                    }
                  }, //todo: update onPressed
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
            ],
          ),
        ),
    )

    );
  }
}


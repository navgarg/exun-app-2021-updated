import 'package:flutter/material.dart';

import '../constants.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 50.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email'
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                    labelText: 'Password'
                ),
              ),
              SizedBox(
                height: 85.0,
              ),
              ElevatedButton(
                  onPressed: (){},
                  child: Text('Login',
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

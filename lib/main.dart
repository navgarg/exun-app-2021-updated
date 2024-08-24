import 'package:exun_app_21/constants.dart';
import 'package:exun_app_21/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import './screens/tabs_screen.dart';
import './screens/login_screen.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print("hi");
  await Firebase.initializeApp(
    name: 'exun-2021',
    options: DefaultFirebaseOptions.currentPlatform,
   // options: DefaultFirebaseOptions.currentPlatform, //todo:check??
  );
  print("after initialise");
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print("in build for main.dart");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Exun App 2021-22',
      theme: ThemeData(
        fontFamily: "Trebuchet MS",
        primaryColor: KColors.blue,
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            color: KColors.primaryText,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
     home: const TabsScreen(),
     //  home: StreamBuilder(
     //      stream: FirebaseAuth.instance.authStateChanges(),
     //      builder: (context, snapshot) {
     //        if (!snapshot.hasData){
     //          //in case null user is returned.
     //          print("snapshot has data");
     //          // return LoginScreen();
     //          return SignInScreen (
     //            providers: [
     //              EmailAuthProvider(),
     //
     //            ],
     //            headerBuilder: (context, constraints, shrinkOffset) {
     //              return Padding(
     //                padding: const EdgeInsets.all(20),
     //                child: AspectRatio(
     //                  aspectRatio: 1,
     //                  child: Image.asset('assets/logo.png'),
     //                ),
     //              );
     //            },
     //          );
     //        }
     //        //in case of successful authentication.
     //        return const TabsScreen();
     //      },
     //  )
    );
  }
}



import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/auth/authScreen.dart';
import 'package:to_do_app/screens/pages/home.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            brightness: Brightness.dark, primaryColor: Colors.purple.shade400),
        home: FutureBuilder(
          future: Firebase.initializeApp(),
          builder: (context, usersnapshot) {
            if (usersnapshot.hasData) {
              return HomePage();
            } else {
             return AuthScreen();
            }
          },
        ));
  }
}

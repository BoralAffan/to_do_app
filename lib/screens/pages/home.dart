import 'package:flutter/material.dart';
import 'package:to_do_app/auth/authForm.dart';
import 'package:to_do_app/auth/authScreen.dart';
import 'package:to_do_app/main.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home page"),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,  MaterialPageRoute(builder: (context) => MyApp()));
              },
              icon: Icon(Icons.arrow_forward),
              color: Colors.white)
        ],
      ),
    );
  }
}

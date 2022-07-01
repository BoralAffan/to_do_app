import 'package:flutter/material.dart';

class signupScreen extends StatefulWidget {
  signupScreen({Key? key}) : super(key: key);

  @override
  State<signupScreen> createState() => _signupScreenState();
}

class _signupScreenState extends State<signupScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
   appBar: AppBar(title: Text('sign up screen'),),

   body: Scaffold(
     body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
   
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'Enter username'
            ),
          ),
           TextField(
            decoration: InputDecoration(
              labelText: 'Enter email'
            ),
          ),
           TextField(
            decoration: InputDecoration(
              labelText: 'Enter password'
            ),
   
            
          ),
           TextField(
            decoration: InputDecoration(
              labelText: 'Confirm Password'
            ),
          ),
        ],
      ),
     ),
   ),

    );
  }
}
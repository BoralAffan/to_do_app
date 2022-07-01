import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController _titlecontroller = new TextEditingController();
  TextEditingController _descriptioncontroller = new TextEditingController();

  addtasktofirebase() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User user = await auth.currentUser!;
    String uid = user.uid;
    var time = DateTime.now();
    await FirebaseFirestore.instance
        .collection('tasks')
        .doc(uid)
        .collection('mytasks')
        .doc(time.toString())
        .set({
      'title': _titlecontroller.text,
      'description': _descriptioncontroller.text,
      'time': time.toString(),
      'timestamp': time
    });

    Fluttertoast.showToast(msg: 'Data added');
    _titlecontroller.clear();
    _descriptioncontroller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add new tasks')),
      body: Container(
        padding: EdgeInsets.all(8.0),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                controller: _titlecontroller,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(width: 3, color: Colors.blueGrey),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide:
                            BorderSide(width: 3, color: Colors.green.shade400)),
                    hintText: "Enter Title",
                    labelText: 'Title'),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                controller: _descriptioncontroller,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(width: 3, color: Colors.blueGrey),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide:
                            BorderSide(width: 3, color: Colors.green.shade400)),
                    hintText: "Enter Description",
                    labelText: 'Description'),
              ),
            ),
            Container(
                padding: EdgeInsets.all(10.0),
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.pink,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                    onPressed: () {
                      addtasktofirebase();
                    },
                    child: Text(
                      'Add Task ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ))),
          ],
        ),
      ),
    );
  }
}

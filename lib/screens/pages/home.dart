import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/auth/authForm.dart';
import 'package:to_do_app/auth/authScreen.dart';
import 'package:to_do_app/main.dart';
import 'package:to_do_app/screens/pages/addTask.dart';
import 'package:to_do_app/screens/pages/description.dart';
import 'package:to_do_app/screens/signUp.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //const HomePage({Key? key}) : super(key: key);
  String uid = '';

  @override
  void initState() {
    getuid();
    super.initState();
  }

  void getuid() async {
    User user = await FirebaseAuth.instance.currentUser!;
    setState(() {
      uid = user.uid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Home page"),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
              onPressed: () async {
                log('logout');
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AuthForm()));
              },
              icon: Icon(Icons.logout),
              color: Colors.white)
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(13),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.height,
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('tasks')
                .doc(uid)
                .collection('mytasks')
                .snapshots(),
            // initialData: initialData,
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Container(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                var doc = snapshot.data.docs;
                return ListView.builder(
                  itemBuilder: ((context, index) {
                    var time = (doc[index]['timestamp'] as Timestamp).toDate();

                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Description(
                                      title: doc[index]['title'],
                                      description: doc[index]['description'],
                                    )));
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 13),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xff121211)),
                        padding: EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(doc[index]['title'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20)),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  DateFormat.yMd().add_jm().format(time),
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                            Container(
                                child: IconButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return Dialog(
                                              child: Container(
                                                height: 200,
                                                width: 200,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: Center(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                          'Are you sure! you want to delete?'),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          TextButton(
                                                              onPressed: () {
                                                                FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'tasks')
                                                                    .doc(uid)
                                                                    .collection(
                                                                        'mytasks')
                                                                    .doc(doc[
                                                                            index]
                                                                        [
                                                                        'time'])
                                                                    .delete();
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child:
                                                                  Text('Yes')),
                                                          TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child:
                                                                  Text('No')),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          });
                                      // FirebaseFirestore.instance
                                      //     .collection('tasks')
                                      //     .doc(uid)
                                      //     .collection('mytasks')
                                      //     .doc(doc[index]['time'])
                                      //     .delete();
                                    },
                                    icon: Icon(Icons.delete))),
                          ],
                        ),
                      ),
                    );
                  }),
                  itemCount: doc.length,
                );
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddTask()));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

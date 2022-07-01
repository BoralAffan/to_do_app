import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/screens/pages/loginScreen.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  // final _formkey = GlobalKey<FormState>();
  // var _email = '';
  // var _password = '';
  // var _username = '';
  bool isLogin = false;

  // startauthentication() {
  //   final validity = _formkey.currentState!.validate();
  //   FocusScope.of(context).unfocus();

  //   if (validity) {
  //     _formkey.currentState?.save();
  //     submitForm(_email,_password,_username);
  //   }
  // }

  // submitForm(String email, String password, String username) async {
  //   final auth = FirebaseAuth.instance;
  //   UserCredential userCredential;
  //   try {
  //     if (isLogin) {
  //       userCredential = await auth.signInWithEmailAndPassword(
  //           email: email, password: password);
  //     } else {
  //       userCredential = await auth.createUserWithEmailAndPassword(
  //           email: email, password: password);
  //       String uid = userCredential.user!.uid;
  //     await  FirebaseFirestore.instance
  //           .collection('users')
  //           .doc(uid)
  //           .set({'username': username, 'email': email});
  //     }
  //   } catch (err) {
  //     print(err);
  //   }
  // }

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void creatrAccount() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Account created! login to continue')));

      Navigator.push(
        context,
         MaterialPageRoute(builder: (context) => LoginScreen())
      );
     
    } on FirebaseAuthException catch (ex) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(ex.code.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: EdgeInsets.all(8),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        children: [
          Container(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                keyboardType: TextInputType.text,
                controller: usernameController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    hintText: 'Enter Your Username',
                    labelText: 'Enter username',
                    labelStyle: GoogleFonts.roboto()),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    hintText: 'Enter Email address',
                    labelText: 'Enter Email',
                    labelStyle: GoogleFonts.roboto()),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    hintText: 'Enter Your Password',
                    labelText: 'Enter Password',
                    labelStyle: GoogleFonts.roboto()),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    creatrAccount();
                  },
                  child: Text('Signup',
                      style: GoogleFonts.roboto(
                          fontSize: 15, fontWeight: FontWeight.bold)),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: Text("Already have an account ? Login"))
            ],
          )),
        ],
      ),
    ));
  }
}

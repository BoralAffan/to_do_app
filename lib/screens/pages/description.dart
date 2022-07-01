import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Description extends StatelessWidget {
  final String title, description;

  const Description(
      {super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('description')),
      body: Container(
        margin: EdgeInsets.all(12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            title,
            style: GoogleFonts.lato(fontSize: 30, fontStyle: FontStyle.italic),
          ),
          Text(
            description,
            style: GoogleFonts.oswald(fontSize: 30),
          )
        ]),
      ),
    );
  }
}

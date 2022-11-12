import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix/core/constants.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        kWidth,
        Text(
          title,
          style: GoogleFonts.archivoBlack(fontSize: 30),
        ),
        const Spacer(),
        const Icon(
          Icons.cast,
          color: Colors.white,
          size: 30,
        ),
        kWidth,
        Container(
          height: 30,
          width: 30,
         decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/ntflixAvat.jpg'))
         ),
        ),
        kWidth,
      ],
    );
  }
}

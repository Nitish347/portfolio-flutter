import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Customtext extends StatelessWidget {
  String text;
   Customtext({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    bool isMobile = size.width < 600;
    return   Stack(
      alignment: Alignment.center,
      children: [
        // Background bold grey text
        Text(
          text,
          style: GoogleFonts.orbitron(
            fontSize: isMobile ? size.width * 0.12 : size.width * 0.03,
            fontWeight: FontWeight.w900,
            color: Colors.grey.withOpacity(0.5),
          ),
        ),
        // Foreground smaller green text
        Text(
          text,
          style: GoogleFonts.orbitron(
            fontSize: isMobile ? size.width * 0.08 : size.width * 0.02,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

import 'dart:ui';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:glossy/glossy.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:random_text_reveal/random_text_reveal.dart';

import '../about/skill_card.dart';
import 'my_card.dart';
import 'my_works.dart';

class HomeSection extends StatefulWidget {
  HomeSection({Key? key}) : super(key: key);

  @override
  _HomeSectionState createState() => _HomeSectionState();
}

class _HomeSectionState extends State<HomeSection> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    bool isMobile = size.width < 600; // Check if the screen is mobile

    return Container(
      height: size.height,
      width: double.infinity,
      child: Stack(
        children: [
          // Parallax background movement
          Positioned.fill(
            child: Stack(
              children: [
                Image.asset(
                  'assets/background.jpg', // Ensure this image is not red
                  fit: BoxFit.cover,
                ),
                Positioned.fill(
                  child: Image.asset(
                    'assets/background.jpg', // Ensure this image is not red
                    fit: BoxFit.cover,
                  ),
                ),
                // Positioned.fill(
                //   child: BackdropFilter(
                //     filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                //     child: Container(
                //       color: Colors.black.withOpacity(0.3), // Makes the blur effect visible
                //     ),
                //   ),
                // ),
                MyCard(),
                MyWorks()

              ],
            ),
          ),
        ],
      ),
    );
  }
}

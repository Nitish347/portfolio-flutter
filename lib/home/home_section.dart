import 'package:flutter/material.dart';
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
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Colors.white,
        Colors.greenAccent,
        Colors.green,
        Colors.green,
        Colors.green,
      ]
              , begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),
      child: Stack(
        children: [
          // Parallax background movement
          Positioned.fill(
            child: Stack(
              children: [
                // Image.asset(
                //   'assets/background.jpg', // Ensure this image is not red
                //   fit: BoxFit.cover,
                // ),
                Positioned.fill(
                  child: Image.asset(
                    'assets/bg.png', // Ensure this image is not red
                    fit: BoxFit.cover,
                  ),
                ),
                const MyCard(),
                const MyWorks()
              ],
            ),
          ),
        ],
      ),
    );
  }
}

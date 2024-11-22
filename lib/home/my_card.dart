import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:glossy/glossy.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:random_text_reveal/random_text_reveal.dart';

class MyCard extends StatefulWidget {
  const MyCard({super.key});

  @override
  State<MyCard> createState() => _MyCardState();
}

late AnimationController _controller;
late Animation<double> _animation;

class _MyCardState extends State<MyCard> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    // Create animation for background movement
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 15))
      ..repeat(reverse: true);
    _animation = Tween<double>(begin: 0, end: 30).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final GlobalKey<RandomTextRevealState> globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    bool isMobile = size.width < 1000;
    return Stack(
      children: [
        Align(
          alignment: isMobile ? Alignment.topCenter : Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.only(left: isMobile ? 0 : 50, top: isMobile ? 30 : 50,),
            child: GlossyContainer(
              width: isMobile ? size.width * 0.95 : size.width * 0.35,
              height: isMobile ? size.height * 0.5 : size.height * 0.8,
              imageOpacity: 0.1,
              strengthX: 10,
              strengthY: 10,
              borderRadius: BorderRadius.circular(20),
              child:Padding(
                padding: EdgeInsets.only(top: isMobile ? 0 : 50),
                child: SizedBox(
                  width: isMobile ? size.width * 0.95 : size.width * 0.35,
                  height: isMobile ? size.height * 0.5 : size.height * 0.8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Glowing circle avatar
                      Container(
                        width: isMobile ? 100 : 150,
                        height: isMobile ? 100 : 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.blueAccent,
                            width: isMobile ? 3 : 5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blueAccent.withOpacity(0.6),
                              blurRadius: 25,
                              spreadRadius: 5,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                        child: AvatarGlow(
                          startDelay: const Duration(milliseconds: 1000),
                          glowColor: Colors.green,
                          glowShape: BoxShape.circle,
                          glowRadiusFactor: 0.4,
                          duration: Duration(seconds: 2),
                          glowCount: 3,
                          child: const Material(
                            elevation: 8.0,
                            shape: CircleBorder(),
                            color: Colors.green,
                            child: CircleAvatar(
                              backgroundImage: AssetImage('assets/images.jpg'),
                              radius: 50.0,
                            ),
                          ),
                        ),
                      ).animate().scale(delay: 500.ms, duration: 1.seconds).fadeIn(),
                      SizedBox(height: isMobile ? 20 : 100),
                      // Animated text with typing effect
                      RandomTextReveal(
                        key: globalKey,
                        text: 'Hi, I\'m Nitish Chaurasiya',
                        initialText: 'Ae8&vNQ32cK^',
                        shouldPlayOnStart: true,
                        textAlign: TextAlign.center,
                        duration: const Duration(seconds: 2),
                        style: GoogleFonts.orbitron(
                          textStyle: const TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 7,
                          ),
                        ),
                        randomString: Source.alphabets,
                        onFinished: () {
                          debugPrint('Password cracked successfully');
                        },
                        curve: Curves.easeIn,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      // AnimatedTextKit(
                      //   animatedTexts: [
                      //     TypewriterAnimatedText(
                      //       'Hi, I\'m Nitish Chaurasiya',
                      //       textStyle: TextStyle(
                      //         fontSize: isMobile ? 24 : 40,
                      //         fontWeight: FontWeight.bold,
                      //         color: Colors.white,
                      //       ),
                      //       speed: Duration(milliseconds: 100),
                      //     ),
                      //   ],
                      //   totalRepeatCount: 1,
                      // ),
                      SizedBox(height: isMobile ? 10 : 20),
                      // Simple Text for "Flutter Developer"
                      Text(
                        'App Developer',
                        style: GoogleFonts.orbit(
                          fontSize: isMobile ? 20 : 30,
                          color: Colors.white70,
                        ),
                      ).animate().fadeIn(duration: 2.seconds),
                      SizedBox(height: isMobile ? 20 : 40),
                      // Download Resume Button with ripple effect
                      ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          'Download Resume',
                          style: GoogleFonts.orbit(color: Colors.green, fontSize: isMobile ? 14 : 20),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            horizontal: isMobile ? 16 : 20,
                            vertical: isMobile ? 8 : 10,
                          ),
                        ),
                      ).animate().shimmer(duration: 2.seconds, delay: 1.seconds),
                    ],
                  ),
                ),
              ) ,
            ),
          ),
        ),
      ],
    );
  }
}

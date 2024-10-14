import 'dart:ui';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HomeSection extends StatefulWidget {
  HomeSection({Key? key}) : super(key: key);

  @override
  _HomeSectionState createState() => _HomeSectionState();
}

class _HomeSectionState extends State<HomeSection> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

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

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: MediaQuery.of(context).size.height,
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
                  child: Transform.translate(
                    offset: Offset(0, _animation.value),
                    child: Image.asset(
                      'assets/background.jpg', // Ensure this image is not red
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                    child: Container(
                      color: Colors.black.withOpacity(0.3), // Makes the blur effect visible
                    ),
                  ),
                ),
              ],
            ),
          )
,
          // Add floating Lottie animation for stars
          // Animated moving background shapes

          Positioned(
            right: -50,
            top: 100,
            child: MovingCircle(color: Colors.pinkAccent.withOpacity(0.3), size: 0),
          ),
          // Center content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Glowing circle avatar
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.blueAccent,
                      width: 5,
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
                  child:AvatarGlow(
                    startDelay: const Duration(milliseconds: 1000),

                    glowColor: Colors.green,
                    glowShape: BoxShape.circle,
                    // animate: _animate,
                    curve: Curves.fastOutSlowIn,
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
                ).animate().scale(delay: 500.ms, duration: 1.seconds).fadeIn(),  // Adding scale and fade-in animation
                SizedBox(height: 30),
                // Animated text with typing effect
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Hi, I\'m Nitish Chaurasiya',
                      textStyle: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      speed: Duration(milliseconds: 100),
                    ),
                  ],
                  totalRepeatCount: 1,
                ),
                SizedBox(height: 20),
                // Simple Text for "Flutter Developer"
                Text(
                  'App Developer',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white70,
                  ),
                ).animate().fadeIn(duration: 2.seconds),  // Adding fade-in animation
                SizedBox(height: 40),
                // Download Resume Button with ripple effect
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Download Resume',style: TextStyle(color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    textStyle: TextStyle(fontSize: 20,color: Colors.white),
                  ),
                ).animate().shimmer(duration: 2.seconds, delay: 1.seconds), // Shimmer effect on the button
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Moving Circle widget for background animation
class MovingCircle extends StatefulWidget {
  final Color color;
  final double size;

  MovingCircle({required this.color, required this.size});

  @override
  _MovingCircleState createState() => _MovingCircleState();
}

class _MovingCircleState extends State<MovingCircle> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 10))
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            _controller.value * 200 - 100, // Move the circle left and right
            _controller.value * 100 - 50,  // Move the circle up and down
          ),
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.color,
            ),
          ),
        );
      },
    );
  }
}

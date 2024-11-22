import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class NavigationBar1 extends StatelessWidget {
  final GlobalKey homeKey;
  final GlobalKey aboutKey;
  final GlobalKey projectsKey;
  final GlobalKey contactKey;
  final bool isVertical;

  NavigationBar1({
    required this.homeKey,
    required this.aboutKey,
    required this.projectsKey,
    required this.contactKey,
    required this.isVertical,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isVertical ? 80 : null,
      height: isVertical ? double.infinity : 60,
      margin: EdgeInsets.symmetric(horizontal: isVertical ? 0 : 40, vertical: isVertical ? 40 : 20),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: isVertical
          ? Column( // Vertical layout
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          NavBarItem('Home', () => _scrollToSection(homeKey)),
          SizedBox(height: 20),
          NavBarItem('Work', () => _scrollToSection(projectsKey)),
          SizedBox(height: 20),
          NavBarItem('About', () => _scrollToSection(aboutKey)),
          SizedBox(height: 20),
          NavBarItem('Contact', () => _scrollToSection(contactKey)),
        ],
      ).animate().fadeIn(delay: 500.ms, duration: 1000.ms).slideX(begin: -1.0)
          : Row( // Horizontal layout
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          NavBarItem('Home', () => _scrollToSection(homeKey)),
          NavBarItem('Work', () => _scrollToSection(projectsKey)),
          NavBarItem('About', () => _scrollToSection(aboutKey)),
          NavBarItem('Contact', () => _scrollToSection(contactKey)),
        ],
      ).animate().fadeIn(delay: 500.ms, duration: 1000.ms).slideY(begin: -1.0),
    );
  }

  void _scrollToSection(GlobalKey key) {
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }
}

class NavBarItem extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  NavBarItem(this.title, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.green,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }
}

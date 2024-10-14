import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class NavigationBar1 extends StatelessWidget {
  final GlobalKey homeKey;
  final GlobalKey aboutKey;
  final GlobalKey projectsKey;
  final GlobalKey contactKey;

  NavigationBar1({
    required this.homeKey,
    required this.aboutKey,
    required this.projectsKey,
    required this.contactKey,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.transparent,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          NavBarItem('Home', () => _scrollToSection(homeKey)),
          NavBarItem('About', () => _scrollToSection(aboutKey)),
          NavBarItem('Projects', () => _scrollToSection(projectsKey)),
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

class NavBarItem extends StatefulWidget {
  final String title;
  final VoidCallback onPressed;

  NavBarItem(this.title, this.onPressed);

  @override
  _NavBarItemState createState() => _NavBarItemState();
}

class _NavBarItemState extends State<NavBarItem> with TickerProviderStateMixin {
  bool _isHovering = false;
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  late Animation<Color?> _textColorAnimation;

  @override
  void initState() {
    super.initState();
    // Animation controller for color transitions
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    // Define animations for background and text color changes
    _colorAnimation = ColorTween(
      begin: Colors.transparent,
      end: Colors.blueAccent.withOpacity(0.2),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _textColorAnimation = ColorTween(
      begin: Colors.white,
      end: Colors.green,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => _onHover(true),
      onExit: (event) => _onHover(false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: _colorAnimation.value,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                widget.title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: _textColorAnimation.value,
                  letterSpacing: 1.2,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _onHover(bool isHovering) {
    setState(() {
      _isHovering = isHovering;
      if (_isHovering) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }
}


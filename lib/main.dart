import 'package:flutter/material.dart';
import 'home/home_section.dart';
import 'about/about_section.dart';
import 'projects_section.dart';
import 'contact_section.dart';

void main() {
  runApp(MyPortfolio());
}

class MyPortfolio extends StatelessWidget {
  final GlobalKey homeKey = GlobalKey();
  final GlobalKey aboutKey = GlobalKey();
  final GlobalKey projectsKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nitish Chaurasiya - Portfolio',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = constraints.maxWidth < 600; // Mobile breakpoint

          return Scaffold(
            extendBody: true,
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              actions: isMobile
                  ? [
                PopupMenuButton<String>(
                  onSelected: (value) => _handleNavigation(value),
                  itemBuilder: (context) => [
                    PopupMenuItem(value: 'Home', child: Text('Home')),
                    PopupMenuItem(value: 'About', child: Text('About')),
                    PopupMenuItem(value: 'Projects', child: Text('Projects')),
                    PopupMenuItem(value: 'Contact', child: Text('Contact')),
                  ],
                ),
              ]
                  : [
                TextButton(
                  onPressed: () => _scrollToSection(homeKey),
                  child: Text('Home', style: TextStyle(color: Colors.green)),
                ),
                TextButton(
                  onPressed: () => _scrollToSection(aboutKey),
                  child: Text('About', style: TextStyle(color: Colors.green)),
                ),
                TextButton(
                  onPressed: () => _scrollToSection(projectsKey),
                  child: Text('Projects', style: TextStyle(color: Colors.green)),
                ),
                TextButton(
                  onPressed: () => _scrollToSection(contactKey),
                  child: Text('Contact', style: TextStyle(color: Colors.green)),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  HomeSection(key: homeKey),
                  AboutSection(key: aboutKey),
                  ProjectsSection(key: projectsKey),
                  ContactSection(key: contactKey),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _handleNavigation(String value) {
    switch (value) {
      case 'Home':
        _scrollToSection(homeKey);
        break;
      case 'About':
        _scrollToSection(aboutKey);
        break;
      case 'Projects':
        _scrollToSection(projectsKey);
        break;
      case 'Contact':
        _scrollToSection(contactKey);
        break;
    }
  }

  void _scrollToSection(GlobalKey key) {
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }
}

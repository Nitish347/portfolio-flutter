import 'package:flutter/material.dart';
import 'widgets/navigation_bar.dart';
import 'widgets/home_section.dart';
import 'widgets/about_section.dart';
import 'widgets/projects_section.dart';
import 'widgets/contact_section.dart';

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
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [

              Stack(
                children: [
                  HomeSection(key: homeKey),NavigationBar1(
                    homeKey: homeKey,
                    aboutKey: aboutKey,
                    projectsKey: projectsKey,
                    contactKey: contactKey,
                  ),
                ],
              ),    // Attach keys to sections
              AboutSection(key: aboutKey),
              ProjectsSection(key: projectsKey),
              ContactSection(key: contactKey),
            ],
          ),
        ),
      ),
    );
  }
}

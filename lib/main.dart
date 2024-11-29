import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'home/home_section.dart';
import 'about/about_section.dart';
import 'projects_section.dart';
import 'contact_section.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions (
      apiKey: "AIzaSyAE7RDBeBQnNd7G_1JXSSx6daVN-3hLNEU",
      authDomain: "sihapp-2bc87.firebaseapp.com",
      projectId: "sihapp-2bc87",
      storageBucket: "sihapp-2bc87.firebasestorage.app",
      messagingSenderId: "270653334549",
      appId: "1:270653334549:web:1d56e83fd6a4e77402da1c",
      measurementId: "G-7FQEQN476W"
    ),
  );
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
              elevation: 0,
              actions: isMobile
                  ? [
                PopupMenuButton<String>(
                  onSelected: (value) => _handleNavigation(value),
                  surfaceTintColor: Colors.green,
                  color: Colors.green,
                  iconColor: Colors.green,
                  itemBuilder: (context) => [
                    const PopupMenuItem(value: 'Home', child: Text('Home',style: TextStyle(color: Colors.white),)),
                    const PopupMenuItem(value: 'About', child: Text('About',style: TextStyle(color: Colors.white))),
                    const PopupMenuItem(value: 'Projects', child: Text('Projects',style: TextStyle(color: Colors.white))),
                    const PopupMenuItem(value: 'Contact', child: Text('Contact',style: TextStyle(color: Colors.white))),
                  ],
                ),
              ]
                  : [
                TextButton(
                  onPressed: () => _scrollToSection(homeKey),
                  child: const Text('Home', style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold)),
                ),
                TextButton(
                  onPressed: () => _scrollToSection(aboutKey),
                  child: const Text('About', style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold)),
                ),
                TextButton(
                  onPressed: () => _scrollToSection(projectsKey),
                  child: const Text('Projects', style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold)),
                ),
                TextButton(
                  onPressed: () => _scrollToSection(contactKey),
                  child:  const Text('Contact', style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: 100,)
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
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }
}

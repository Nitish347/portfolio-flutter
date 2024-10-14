import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutSection extends StatelessWidget {
  AboutSection({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(40),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center, // Align both texts at the center
            children: [
              // Background bold grey text
              Text(
                'About Me',
                style: GoogleFonts.poppins(
                  fontSize: 80, // Large font size for background text
                  fontWeight: FontWeight.w900, // Bold style
                  color: Colors.grey.withOpacity(0.2), // Grey color with some transparency
                ),
              ),
              // Foreground green small text
              Text(
                'About Me',
                style: GoogleFonts.poppins(
                  fontSize: 50,
                  fontWeight: FontWeight.w600,// Smaller font size for the top text
                  color: Colors.green, // Green color
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Text(
            """ I am Nitish Chaurasiya, an app developer with a passion for building innovative and user-friendly mobile applications. I hold a Bachelor's degree in Technology from Ajay Kumar Garg Engineering College, where I developed strong skills in Flutter, Dart, and Firebase.

I have worked on multiple projects, including "Soundscape," an audio player with over 10K downloads, and "European-Pay," a digital payment app. As a freelancer, I've developed 15+ apps for clients worldwide.

With experience in app development, problem-solving, and competing in hackathons, I continuously strive to create impactful digital solutions.""",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'skill_card.dart';

class AboutSection extends StatelessWidget {
  AboutSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    bool isMobile = size.width < 600; // Define mobile breakpoint
    bool isTablet = size.width < 900 && size.width >= 600; // Tablet breakpoint
    bool isWeb = size.width >= 900; // Web breakpoint

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 40,
        vertical: isMobile ? 20 : 40,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Section Title
          Stack(
            alignment: Alignment.center,
            children: [
              // Background bold grey text
              Text(
                'About Me',
                style: GoogleFonts.poppins(
                  fontSize: isMobile ? size.width * 0.12 : size.width * 0.06,
                  fontWeight: FontWeight.w900,
                  color: Colors.grey.withOpacity(0.2),
                ),
              ),
              // Foreground smaller green text
              Text(
                'About Me',
                style: GoogleFonts.poppins(
                  fontSize: isMobile ? size.width * 0.08 : size.width * 0.04,
                  fontWeight: FontWeight.w800,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          SizedBox(height: isMobile ? 10 : 10),

          _buildResponsiveTimeline(context),
          // Timeline Section
          // if (isMobile) ...[
          // Mobile View: Single Column Timeline
          // _buildSingleColumnTimeline(context),
          // ] else ...[
          // Tablet or Web View: Two Timelines Side by Side
          // _buildDoubleColumnTimeline(isTablet),
          // ],
          SizedBox(height: isMobile ? 30 : 10),
          // Skill Section
          Text(
            "Skills",
            style: GoogleFonts.poppins(
              fontSize: isMobile ? size.width * 0.04 : size.width * 0.02,
              fontWeight: FontWeight.w800,
              color: Colors.green,
            ),
          ),
          SizedBox(height: isMobile ? 30 : 40),
          const Wrap(
            alignment: WrapAlignment.center,
            spacing: 40,
            runSpacing: 40,
            children: [
              AnimatedSkillCard(
                assetPath: 'assets/logo/flutter.svg',
                skillName: 'Flutter',
              ),
              AnimatedSkillCard(
                assetPath: 'assets/logo/dart.svg',
                skillName: 'Dart',
              ),
              AnimatedSkillCard(
                assetPath: 'assets/logo/firebase.svg',
                skillName: 'Firebase',
              ),
              AnimatedSkillCard(
                assetPath: 'assets/logo/django.svg',
                skillName: 'Django',
              ),
              AnimatedSkillCard(
                assetPath: 'assets/logo/apple.svg',
                skillName: 'iOS',
              ),
              AnimatedSkillCard(
                assetPath: 'assets/logo/android.svg',
                skillName: 'Android',
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Method to build a single column timeline (for Mobile)
  Widget _buildResponsiveTimeline(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 800;

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Divider(
                  color: Colors.green,
                ),
                SizedBox(height: isMobile ? 20 : 40),
                _buildTimelineColumn2(context, " Achievement"),
                Divider(
                  color: Colors.green,
                ),
                SizedBox(height: isMobile ? 20 : 40),
                _buildTimelineColumn(context, "Education"),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTimelineColumn2(context, "Achievement"),
                Divider(
                  color: Colors.green,
                ),
                _buildTimelineColumn(context, "Education"),
              ],
            ),
    );
  }

  Widget _buildTimelineColumn(BuildContext context, String text) {
    bool isMobile = MediaQuery.of(context).size.width < 800;

    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: isMobile ? MediaQuery.of(context).size.width : MediaQuery.of(context).size.width * 0.22,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: isMobile ? size.width * 0.06 : size.width * 0.02,
              fontWeight: FontWeight.w800,
              color: Colors.green,
            ),
          ),
          SizedBox(height: isMobile ? 20 : 20),
          _buildTimelineItem(
            title: "Ajay Kumar Garg Engineering College",
            subtitle: "B.Tech in Computer Science (2021-2024)",
            isFirst: true,
            isLast: false,
          ),
          _buildTimelineItem(
            title: "Surya International Academy",
            subtitle: "High School & Intermediate (2017-2019)",
            isFirst: false,
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineColumn2(BuildContext context, String text) {
    bool isMobile = MediaQuery.of(context).size.width < 800;

    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: isMobile ? MediaQuery.of(context).size.width : MediaQuery.of(context).size.width * 0.2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Section Header

          // Achievements Section
          Text(
            "Achievements",
            style: GoogleFonts.poppins(
              fontSize: isMobile ? size.width * 0.06 : size.width * 0.02,
              fontWeight: FontWeight.w800,
              color: Colors.green,
            ),
          ),
          SizedBox(height: isMobile ? 20 : 20),

          // Achievements List
          _buildAchievementItem("Winner - Shankara Global Hackathon 2023"),
          _buildAchievementItem("Finalist - Smart India Hackathon 2022"),
          _buildAchievementItem("Finalist - Anveshna 2023"),
          _buildAchievementItem("Finalist - Rajasthan IT Day Hackathon 2023"),
          _buildAchievementItem("Solved 400+ DSA questions on various platforms."),
          _buildAchievementItem(
              "Flipkart GRiD 4.0: Level 1 Qualifier - among the top 7 teams to qualify from college."),
          _buildAchievementItem("Got 3150th rank in Google Kickstart"),
        ],
      ),
    );
  }

  Widget _buildAchievementItem(String achievement) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: Colors.green, size: 20),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              achievement,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey[800],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Timeline Item Widget
  Widget _buildTimelineItem({
    required String title,
    required String subtitle,
    required bool isFirst,
    required bool isLast,
  }) {
    return Center(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Glowing Animated Circle
              SizedBox(height: 10,),
              AvatarGlow(
                startDelay: const Duration(milliseconds: 800),
                glowColor: Colors.green,
                glowShape: BoxShape.circle,
                child: AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.withOpacity(0.5),
                        blurRadius: 10,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[700],
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

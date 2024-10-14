import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class ProjectsSection extends StatelessWidget {
  ProjectsSection({Key? key}) : super(key: key);

  final List<Map<String, String>> projects = [
    {
      'title': 'Soundscape',
      'description': 'An audio player based on mood, frequencies, and more.',
      'link': 'https://play.google.com/store/apps/details?id=com.dps.europeanpay',
    },
    {
      'title': 'European-Pay',
      'description': 'A digital payment app like Paytm and PhonePe.',
      'link': 'https://play.google.com/store/apps/details?id=com.dps.europeanpay',
    },
    {
      'title': 'Eklavya',
      'description': 'An educational app for students.',
      'link': 'https://github.com/Nitish347',
    },   {
      'title': 'Soundscape',
      'description': 'An audio player based on mood, frequencies, and more.',
      'link': 'https://play.google.com/store/apps/details?id=com.dps.europeanpay',
    },
    {
      'title': 'European-Pay',
      'description': 'A digital payment app like Paytm and PhonePe.',
      'link': 'https://play.google.com/store/apps/details?id=com.dps.europeanpay',
    },
    {
      'title': 'Eklavya',
      'description': 'An educational app for students.',
      'link': 'https://github.com/Nitish347',
    }, {
      'title': 'Eklavya',
      'description': 'An educational app for students.',
      'link': 'https://github.com/Nitish347',
    },   {
      'title': 'Soundscape',
      'description': 'An audio player based on mood, frequencies, and more.',
      'link': 'https://play.google.com/store/apps/details?id=com.dps.europeanpay',
    },
    {
      'title': 'European-Pay',
      'description': 'A digital payment app like Paytm and PhonePe.',
      'link': 'https://play.google.com/store/apps/details?id=com.dps.europeanpay',
    },
    {
      'title': 'Eklavya',
      'description': 'An educational app for students.',
      'link': 'https://github.com/Nitish347',
    },
  ];

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
                'PROJECT',
                style: GoogleFonts.poppins(
                  fontSize: 80, // Large font size for background text
                  fontWeight: FontWeight.w900, // Bold style
                  color: Colors.grey.withOpacity(0.2), // Grey color with some transparency
                ),
              ),
              // Foreground green small text
              Text(
                'Project',
                style: GoogleFonts.poppins(
                  fontSize: 50,
                  fontWeight: FontWeight.w600,// Smaller font size for the top text
                  color: Colors.green, // Green color
                ),
              ),
            ],
          )
,
          SizedBox(height: 20),
          Container(

            decoration: BoxDecoration(
              // color: Colors.green.withOpacity(0.5),
            ),
            padding: EdgeInsets.all(20),
            child: Wrap(
              spacing: 50,
              runSpacing: 50,
              children: projects.map((project) {
                return ProjectCard(project: project);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class ProjectCard extends StatefulWidget {
  final Map<String, String> project;

  ProjectCard({required this.project});

  @override
  _ProjectCardState createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> with TickerProviderStateMixin {
  bool _isHovering = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _gradientStartAnimation;
  late Animation<Color?> _gradientEndAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    // Scale animation for hover effect
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Gradient color animations
    _gradientStartAnimation = ColorTween(
      begin: Colors.teal,
      end: Colors.teal,

    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _gradientEndAnimation = ColorTween(
      begin: Colors.blueAccent,
      end: Colors.black,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
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
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: ClayContainer(
              width: 200,
              height: 350,
              borderRadius: 20,

              child:  Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Placeholder for network image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        'https://via.placeholder.com/300x150', // Dummy image
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      widget.project['title']!,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      widget.project['description']!,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.green.withOpacity(0.8),
                      ),
                    ),
                    SizedBox(height: 20),
                    // ElevatedButton(
                    //   onPressed: () {
                    //     // Handle project link click
                    //     _launchURL(widget.project['link']!);
                    //   },
                    //   style: ElevatedButton.styleFrom(
                    //     backgroundColor: Colors.white.withOpacity(0.9),
                    //     foregroundColor: Colors.blueAccent,
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(10),
                    //     ),
                    //   ),
                    //   child: Text('View Project'),
                    // ),
                  ],
                ),
              ),
            ),
          );
        },
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

  void _launchURL(String url) async {
    // Add your link launch logic here, like using url_launcher
  }
}

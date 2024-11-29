import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view.dart';
import 'package:portfolio_flutter/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectsSection extends StatelessWidget {
  ProjectsSection({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double maxWidth = constraints.maxWidth;

        var size = MediaQuery.of(context).size;
        // Determine responsive styles
        bool isMobile = maxWidth < 600; // Consider screens below 600px as mobile
        int columns = isMobile ? 1 : (maxWidth < 900 ? 2 : 3);
        double horizontalPadding = isMobile ? 20 : 40;

        return Container(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 20),
          child: Column(
            children: [
              // Section Title
              Stack(
                alignment: Alignment.center,
                children: [
                  Text(
                    'WORKS',
                    style: GoogleFonts.poppins(
                      fontSize: isMobile ? size.width * 0.12 : size.width * 0.06,
                      fontWeight: FontWeight.w900,
                      color: Colors.grey.withOpacity(0.2),
                    ),
                  ),
                  Text(
                    'WORKS',
                    style: GoogleFonts.poppins(
                      fontSize: isMobile ? size.width * 0.08 : size.width * 0.04,
                      fontWeight: FontWeight.w900,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Project Cards
              Wrap(
                spacing: 50,
                runSpacing: 50,
                alignment: WrapAlignment.center,
                children: projects.map((project) {
                  return ProjectCard(project: project);
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ProjectCard extends StatefulWidget {
  final Map<String, String> project;

  const ProjectCard({required this.project, Key? key}) : super(key: key);

  @override
  _ProjectCardState createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> with TickerProviderStateMixin {
  bool _isHovering = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    ); // Slightly smaller scale animation for a more subtle effect
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: InkWell(
              onTap: () => _showProjectDetails(context, widget.project),
              child: ClayContainer(
                borderRadius: 10, // Reduced border radius for a sleeker look
                color: !_isHovering ? Colors.white : Colors.white,
                parentColor: Colors.white10,
                depth: !_isHovering ? 15 : 20, // Slightly less depth on hover
                spread: 5, // Reduced shadow spread
                curveType: !_isHovering ? CurveType.concave : CurveType.concave,
                child: Padding(
                  padding: const EdgeInsets.all(12.0), // Reduced padding
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Placeholder for network image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          height: 150, // Reduced image height
                          width: screenWidth < 800 ? screenWidth * 0.8 : 280,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(widget.project['img'] != ""
                                      ? widget.project['img'] ?? ""
                                      : "assets/background.jpg"),
                                  fit: BoxFit.cover)), // Adjusted width for smaller screens
                          // color: Colors.grey,
                          // child: const Center(
                          //   child: Text(
                          //     "Project Image",
                          //     style: TextStyle(color: Colors.white),
                          //   ),
                          // ),
                        ),
                      ),
                      const SizedBox(height: 8), // Reduced gap
                      SizedBox(
                        height: screenWidth < 800 ? 30 : 50,
                        width: screenWidth < 800 ? screenWidth * 0.8 : 250,
                        child: Text(
                          widget.project['title'] ?? "",
                          style: const TextStyle(
                            fontSize: 18, // Reduced font size
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8), // Reduced gap
                      Container(
                        alignment: Alignment.topCenter,
                        height: 90,
                        width: screenWidth < 800 ? screenWidth * 0.8 : 250,
                        child: Text(
                          widget.project['descS'] ?? "",
                          style: TextStyle(
                            fontSize: 16, // Reduced font size
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8), // Reduced gap
                      Text(
                        'Show More',
                        style: TextStyle(color: Colors.blue),
                      )
                    ],
                  ),
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

  void _showProjectDetails(BuildContext context, Map<String, String> project) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true, // Allows dismissal by tapping outside
      barrierLabel: "Dismiss",
      transitionDuration: const Duration(milliseconds: 300), // Animation duration
      pageBuilder: (context, animation, secondaryAnimation) {
        double screenWidth = MediaQuery.of(context).size.width;
        double screenHeight = MediaQuery.of(context).size.height;

        return Center(
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15), // Reduced dialog border radius
            ),
            child: ClayContainer(
              borderRadius: 15,
              depth: 15,
              spread: 0,
              child: Container(
                width: screenWidth < 800
                    ? screenWidth * 0.8
                    : screenWidth * 0.5, // Reduced dialog width
                padding: const EdgeInsets.all(15.0), // Reduced padding
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop(); // Close the current dialog
                        _showImageZoom(context, project['img'] ?? "assets/background.jpg");
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          height: screenWidth < 800
                              ? screenHeight * 0.2
                              : screenHeight * 0.5, // Adjusted image height
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                project['img'] != "" ? project['img']! : "assets/background.jpg",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8), // Reduced gap
                    Text(
                      project['title']!,
                      style: TextStyle(
                        fontSize: 22, // Reduced font size
                        fontWeight: FontWeight.bold,
                        color: Colors.green[700],
                      ),
                    ),
                    const SizedBox(height: 8), // Reduced gap
                    SingleChildScrollView(
                      child: Container(
                        height: screenWidth < 800
                            ? screenHeight * 0.25
                            : screenHeight * 0.2, // Adjusted content height
                        child: Scrollbar(
                          thumbVisibility: true, // Optional: keeps scrollbar visible
                          child: SingleChildScrollView(
                            child: Text(
                              project['desc']!,
                              style: TextStyle(
                                fontSize: 16, // Reduced font size
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15), // Reduced gap
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () async {
                            final url = project['playStore']!;
                            if (await canLaunchUrl(Uri.parse(url))) {
                              await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                          child: Card(
                            elevation: 2,
                            color: Colors.white,
                            child: SizedBox(
                              height: 35,
                              width: 110,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 6), // Reduced padding
                                child: Image.asset(
                                  "assets/logo/google_play.png",
                                  width: 120, // Reduced image width
                                ),
                              ),
                            ),
                          ),
                        ),
                        if (project["web"] != "")
                          InkWell(
                            onTap: () async {
                              final url = project['web']!;
                              if (await canLaunchUrl(Uri.parse(url))) {
                                await launchUrl(Uri.parse(url),
                                    mode: LaunchMode.externalApplication);
                              } else {
                                throw 'Could not launch $url';
                              }
                            },
                            child: Card(
                              color: Colors.white,
                              surfaceTintColor: Colors.white,
                              elevation: 2,
                              child: Container(
                                alignment: Alignment.center,
                                // height: screenWidth*0.025,
                                // width: screenWidth*0.07,
                                height: 35,
                                width: 110,
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                      width: 5,
                                    ),
                                    FaIcon(
                                      FontAwesomeIcons.globe,
                                      color: Colors.black87,
                                    ),
                                    Text(
                                      "Website",
                                      style: TextStyle(fontSize: 15, color: Colors.black87),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text(
                          'Close',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          ),
          child: child,
        );
      },
    );
  }

  void _showImageZoom(BuildContext context, String imagePath) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.black,
          child: PhotoView(
            imageProvider: AssetImage(imagePath),
            backgroundDecoration: const BoxDecoration(
              color: Colors.transparent,
            ),
          ),
        );
      },
    );
  }
}

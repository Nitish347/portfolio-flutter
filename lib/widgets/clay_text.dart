import 'package:clay_containers/clay_containers.dart';
import 'package:clay_containers/widgets/clay_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProjectTitle extends StatelessWidget {
  final bool isMobile;
  final Size size;

  const ProjectTitle({
    Key? key,
    required this.isMobile,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ClayText(
          'PROJECT',
          size: isMobile ? size.width * 0.12 : size.width * 0.06,
          depth: 40, // Strong elevation
          emboss: false, // Elevated effect
          parentColor: Colors.grey[200]!,
          textColor: Colors.grey.withOpacity(0.2),
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w900,
          ),
        ),
        ClayText(
          'Projects',
          size: isMobile ? size.width * 0.08 : size.width * 0.04,
          depth: 20, // Slightly lesser depth
          emboss: true, // Inset effect
          parentColor: Colors.white,
          textColor: Colors.green,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}

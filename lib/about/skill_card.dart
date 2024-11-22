import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AnimatedSkillCard extends StatefulWidget {
  final String assetPath;
  final String skillName;

  const AnimatedSkillCard({
    Key? key,
    required this.assetPath,
    required this.skillName,
  }) : super(key: key);

  @override
  State<AnimatedSkillCard> createState() => _AnimatedSkillCardState();
}

class _AnimatedSkillCardState extends State<AnimatedSkillCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        transform: _isHovered
            ? (Matrix4.identity()..scale(1.2)) // Scale up slightly on hover
            : Matrix4.identity(), // Normal size
        child: ClayContainer(
          height: 110,
          width: 110,
          borderRadius: 15,
          color: !_isHovered ?  Colors.white: Colors.green,
          parentColor: Colors.white10,
          depth: !_isHovered ? 20 : 30, // Decrease depth on hover
          spread: !_isHovered ? 10 : 10, // Subtle shadow adjustment
          curveType: !_isHovered ? CurveType.concave : CurveType.concave, // Change curve type
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  widget.assetPath,
                  height: 50,
                  width: 50,
                ),
              ),
              Text(
                widget.skillName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: _isHovered ? Colors.green[800] : Colors.grey[700],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

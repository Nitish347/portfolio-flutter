import 'dart:developer';

import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactCard extends StatefulWidget {
  final String assetPath;
  final String skillName;
  final String url;

  const ContactCard({
    Key? key,
    required this.assetPath,
    required this.url,
    required this.skillName,
  }) : super(key: key);

  @override
  State<ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<ContactCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    bool isMobile = size.width < 600;

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          transform: _isHovered ? (Matrix4.identity()..scale(1.2)) : Matrix4.identity(),
          child: Row(
            children: [
              InkWell(
                onTap: () async {
                  log(widget.url);
                  if (await canLaunchUrl(Uri.parse(widget.url))) {
                    await launchUrl(Uri.parse(widget.url), mode: LaunchMode.externalApplication);
                  } else {
                    widget.url!="" ?
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Could not launch ${widget.url}")),
                    ) : null;
                  }
                },
                child: ClayContainer(
                  height: 40,
                  width: 55,
                  borderRadius: 500,
                  parentColor: Colors.white10,
                  depth: !_isHovered ? 20 : 30,
                  spread: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.transparent,
                      child: SvgPicture.asset(widget.assetPath),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              if (widget.skillName.isNotEmpty)
                Expanded(
                  child: Text(
                    widget.skillName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: isMobile ? 14 : 16,
                      color: _isHovered ? Colors.green : Colors.grey[700],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

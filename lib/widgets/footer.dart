import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      color: Colors.black,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SocialIcon(icon: Icons.linked_camera, url: 'https://www.linkedin.com/in/nitish-chaurasiya-1085301b9/'),
              SocialIcon(icon: Icons.gite, url: 'https://github.com/Nitish347'),
              SocialIcon(icon: Icons.email, url: 'mailto:nitishchaurasiya3470@gmail.com'),
            ],
          ),
          SizedBox(height: 10),
          Text(
            '© 2024 Nitish Chaurasiya',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class SocialIcon extends StatelessWidget {
  final IconData icon;
  final String url;

  SocialIcon({required this.icon, required this.url});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon),
      color: Colors.white,
      onPressed: () {
        // Handle URL launch
      },
    );
  }
}

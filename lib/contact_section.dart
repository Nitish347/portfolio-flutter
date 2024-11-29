import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_flutter/utils.dart';
import 'package:lottie/lottie.dart';
import 'contact/contact_card.dart';

class ContactSection extends StatelessWidget {
  ContactSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return LayoutBuilder(
      builder: (context, constraints) {
        // Determine if the layout is for a small screen (mobile)
        bool isMobile = constraints.maxWidth < 800;

        return Container(
          width: size.width,
          padding:isMobile ?  EdgeInsets.all(20) :  EdgeInsets.all(60) ,
          child: isMobile
              ? Column(
            // Mobile View: Display Contact and Form in Vertical Order
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildContactForm(context),
              const SizedBox(height: 40,),
              _buildContactInfo(context),
            ],
          )
              : Row(
            // Web/Tablet View: Display Contact and Form Side-by-Side
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(flex: 1, child: _buildContactInfo(context)),

              Expanded(flex: 2, child: _buildContactForm(context)),
            ],
          ),
        );
      },
    );
  }
  Widget _buildContactInfo(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
       
       size.width>800 ? Lottie.asset("assets/contacts/contact_animation.json",height: 250):const SizedBox(),
        ContactCard(
          assetPath: contacts[0]["img"] ?? "",
          skillName: contacts[0]["title"] ?? "", url: contacts[0]["url"] ?? "",
        ),
        ContactCard(
          assetPath: contacts[1]["img"] ?? "",
          skillName: contacts[1]["title"] ?? "",
          url: contacts[0]["url"] ?? "",
        ),
        SizedBox(
          width: double.infinity, // Allow the container to use all available horizontal space
          child: Wrap(
            direction: Axis.horizontal, // Ensure horizontal layout
            alignment: WrapAlignment.start, // Center the items horizontally
            spacing: 10, // Space between each ContactCard
            runSpacing: 0, // Space between rows, if wrapping occurs
            children: List.generate(5, (index) {
              return SizedBox(
                width: 80, // Define a fixed width for each card
                child: ContactCard(
                  assetPath: contacts[index + 2]["img"] ?? "",
                  url: contacts[index+2]["url"] ?? "",
                  skillName: "",
                ),
              );
            }),
          ),
        ),
      ],
    );
  }


  Widget _socialMediaLinks({required String img, required String title, required String subtitle}){
    return Container(

    );
  }
  Widget _buildContactForm(BuildContext context) {
    var size = MediaQuery.of(context).size;
    bool isMobile = size.width < 600; // Define mobile breakpoint
    bool isTablet = size.width < 900 && size.width >= 600; // Tablet breakpoint
    bool isWeb = size.width >= 900; // Web breakpoint
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              // Background bold grey text
              Text(
                'Contact Me',
                style: GoogleFonts.poppins(
                  fontSize: isMobile ? size.width * 0.12 : size.width * 0.06,
                  fontWeight: FontWeight.w900,
                  color: Colors.grey.withOpacity(0.2),
                ),
              ),
              // Foreground smaller green text
              Text(
                'Contact Me',
                style: GoogleFonts.poppins(
                  fontSize: isMobile ? size.width * 0.08 : size.width * 0.04,
                  fontWeight: FontWeight.w800,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          ClayContainer(
            borderRadius: 15,
            color: Colors.white,
            parentColor: Colors.white10,
            depth: 50,
            spread: 10,

            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomTextField(labelText: 'Your Name'),
                  SizedBox(height: 20),
                  CustomTextField(labelText: 'Your Email'),
                  SizedBox(height: 20),
                  CustomTextField(
                    labelText: 'Your Message',
                    maxLines: 5,
                  ),
                  SizedBox(height: 30),
                  _AnimatedSubmitButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTextField extends StatefulWidget {
  final String labelText;
  final int maxLines;

  CustomTextField({required this.labelText, this.maxLines = 1});

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        decoration: BoxDecoration(
          boxShadow: _isHovering
              ? [
            BoxShadow(
              color: Colors.green.withOpacity(0.3),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ]
              : [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: ClayContainer(
          borderRadius: 12,
          color: Colors.white,
          parentColor: Colors.white10,
          depth: _isHovering ? 15 : 20,
          spread: 5,
          child: TextField(
            maxLines: widget.maxLines,
            decoration: InputDecoration(
              labelText: widget.labelText,
              labelStyle: TextStyle(fontSize: 16),
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300, width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.green, width: 2),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AnimatedSubmitButton extends StatefulWidget {
  @override
  __AnimatedSubmitButtonState createState() => __AnimatedSubmitButtonState();
}

class __AnimatedSubmitButtonState extends State<_AnimatedSubmitButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => _onHover(true),
      onExit: (event) => _onHover(false),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        height: 50,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: _isHovering
                ? [Colors.greenAccent, Colors.green]
                : [Colors.lightGreenAccent, Colors.green],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.green.withOpacity(0.3),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 15),
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            'Send Message',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  void _onHover(bool isHovering) {
    setState(() {
      _isHovering = isHovering;
    });
  }
}

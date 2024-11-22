import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_flutter/widgets/customText.dart';
import 'package:glossy/glossy.dart';

class MyWorks extends StatefulWidget {
  const MyWorks({super.key});

  @override
  State<MyWorks> createState() => _MyWorksState();
}

class _MyWorksState extends State<MyWorks> with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  final List<Map<String, String>> logoBrand = [
    {"name": "AppSuccessor\nMedia Pvt Ltd", "img": "assets/brand_logo/appSucc.png"},
    {
      "name": "DOTS",
      "img": "assets/brand_logo/dots.jpg"
    },
    {"name": "European Pay", "img": "assets/brand_logo/european.png"},

    {"name": "ISAP-France", "img": "assets/brand_logo/ISAF.png"},
    {"name": "Trip Builder", "img": "assets/brand_logo/trip.png"},
    {"name": "Eklavya", "img": "assets/brand_logo/eklogo.png"},
  ];

  @override
  void initState() {
    super.initState();

    // Initialize the ScrollController
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Start the automatic scrolling once the widget tree is built
      _startAutoScroll();
    });
  }

  // Method to start the auto scroll
  void _startAutoScroll() {
    const double scrollSpeed = 50; // pixels per second
    const Duration duration = Duration(milliseconds: 500);

    Future<void> scrollStep() async {
      while (_scrollController.hasClients) {
        // Scroll by a fixed amount each time (for a smooth effect)
        await Future.delayed(duration, () {
          if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent) {
            // Jump back to the start when reaching the end
            _scrollController.jumpTo(0);
          } else {
            _scrollController.animateTo(
              _scrollController.position.pixels + scrollSpeed,
              duration: duration,
              curve: Curves.linear,
            );
          }
        });
      }
    }

    scrollStep();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    bool isMobile = size.width < 1000;

    return Positioned.fill(
      top: isMobile ? size.height * 0.55 : size.height * 0.15,
      child: Align(
        alignment: isMobile ? Alignment.center : Alignment.centerRight,
        child: Padding(
          padding: EdgeInsets.only(
            right: isMobile ? 0 : 50,
            top: isMobile ? 30 : 50,
          ),
          child: SizedBox(
            width: isMobile ? size.width : size.width * 0.5,
            child: Column(
              children: [
                Customtext(text: "Worked with"),
                if (isMobile)
                  ClipRect(
                    child: SizedBox(
                      height: size.height * 0.2,
                      child: ListView.builder(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: logoBrand.length * 2, // Double for smooth looping
                        itemBuilder: (context, index) {
                          // Use modulo to cycle through the list
                          final brand = logoBrand[index % logoBrand.length];
                          return _buildLogoCard(brand, size, isMobile);
                        },
                      ),
                    ),
                  )
                else
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 10,
                    runSpacing: 10,
                    children: logoBrand.map((brand) {
                      return _buildLogoCard(brand, size, isMobile);
                    }).toList(),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogoCard(Map<String, String> brand, Size size, bool isMobile) {
    return Padding(
      padding:  const EdgeInsets.symmetric(horizontal: 5),
      child: GlossyContainer(
        width: isMobile ? size.width * 0.4 : size.width * 0.12,
        height: isMobile ? size.width * 0.45 : size.width * 0.13,
        imageOpacity: 0.1,
        strengthX: 25,
        strengthY: 25,
        boxShadow: const [
          BoxShadow(color: Colors.transparent)
        ],

        borderRadius: BorderRadius.circular(10),
        margin: const EdgeInsets.symmetric(horizontal: 0),
        // shadowColor: Colors.transparent, // Ensure no shadow
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(500),
                image: DecorationImage(
                  image: AssetImage(
                    brand["img"] ?? "",
                  ),
                ),
              ),
              height: isMobile ? size.height * 0.1 : size.height * 0.12,
              width: size.width,
            ),
            Expanded(
              child: Text(
                brand["name"] ?? "",
                textAlign: TextAlign.center,
                style: GoogleFonts.orbit(color: Colors.white.withOpacity(0.7), fontWeight: FontWeight.w600, fontSize: isMobile ? 15 : size.width*0.01),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

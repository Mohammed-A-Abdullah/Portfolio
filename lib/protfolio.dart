import 'package:flutter/material.dart';
import 'package:profolio/sections/about.dart';
import 'package:profolio/sections/contact.dart';
import 'package:profolio/sections/home.dart';
import 'package:profolio/sections/projects.dart';
import 'package:profolio/sections/skills.dart';
import 'package:profolio/sections/certificate.dart';
import 'package:profolio/sections/navbar.dart';
import 'package:animate_do/animate_do.dart';
import 'package:profolio/constant.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';

class Protfolio extends StatefulWidget {
  const Protfolio({super.key});

  @override
  State<Protfolio> createState() => _ProtfolioState();
}

class _ProtfolioState extends State<Protfolio> {
  final homeKey = GlobalKey();
  final aboutKey = GlobalKey();
  final projectKey = GlobalKey();
  final skillsKey = GlobalKey();
  final contactKey = GlobalKey();
  final certifiKey = GlobalKey();

  bool aniHome = false;
  bool aniAbout = false;
  bool aniskill = false;
  bool anicotact = false;
  bool aniCertificate = false;
  bool aniproject = false;

  Map<String, GlobalKey> get keysMap => {
    'Home': homeKey,
    'About': aboutKey,
    'Skills': skillsKey,
    'Certificate': certifiKey,
    'Projects': projectKey,
    'Contact': contactKey,
  };

  void _scrollTo(GlobalKey key) {
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  String url = "https://www.linkedin.com/in/mohamed-ahmed-abdullah/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E212D),

      endDrawer: Drawer(
        backgroundColor: sectionColor,
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 20),
          children: keysMap.entries.map((entry) {
            return ListTile(
              title: Text(
                textAlign: TextAlign.center,
                entry.key,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Rubic',
                  color: primaryColor,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                _scrollTo(entry.value);
              },
            );
          }).toList(),
        ),
      ),

      body: Column(
        children: [
          Navbar(onNavClick: _scrollTo, keysMap: keysMap),

          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
                child: Column(
                  children: [
                    VisibilityDetector(
                      key: homeKey,
                      onVisibilityChanged: (info) {
                        setState(() {
                          aniHome = info.visibleFraction > 0;
                        });
                      },
                      child:
                          Container(
                            alignment: Alignment.center,
                            height: 700,
                            child: const Home(),
                          ).fadeInUp(
                            animate: aniHome,
                            duration: const Duration(milliseconds: 500),
                          ),
                    ),

                    VisibilityDetector(
                      key: aboutKey,
                      onVisibilityChanged: (info) {
                        setState(() {
                          aniAbout = info.visibleFraction > 0.09;
                        });
                      },
                      child:
                          Container(
                            constraints: BoxConstraints(minHeight: 500),
                            alignment: Alignment.center,
                            child: const About(),
                          ).fadeInLeft(
                            animate: aniAbout,
                            duration: const Duration(milliseconds: 500),
                          ),
                    ),

                    VisibilityDetector(
                      key: skillsKey,
                      onVisibilityChanged: (info) {
                        setState(() {
                          aniskill = info.visibleFraction > 0;
                        });
                      },
                      child:
                          Container(
                            constraints: BoxConstraints(minHeight: 700),
                            alignment: Alignment.center,
                            child: const Skills(),
                          ).zoomIn(
                            animate: aniskill,
                            duration: const Duration(milliseconds: 500),
                          ),
                    ),

                    VisibilityDetector(
                      key: certifiKey,
                      onVisibilityChanged: (info) {
                        setState(() {
                          aniCertificate = info.visibleFraction > 0;
                        });
                      },
                      child:
                          Container(
                            constraints: BoxConstraints(minHeight: 700),
                            alignment: Alignment.center,
                            child: const Certificate(),
                          ).fadeInDown(
                            animate: aniCertificate,
                            duration: const Duration(milliseconds: 500),
                          ),
                    ),

                    VisibilityDetector(
                      key: projectKey,
                      onVisibilityChanged: (info) {
                        setState(() {
                          aniproject = info.visibleFraction > 0;
                        });
                      },
                      child:
                          Container(
                            constraints: BoxConstraints(minHeight: 700),
                            alignment: Alignment.center,
                            child: const Projects(),
                          ).fadeInDown(
                            animate: aniproject,
                            duration: const Duration(milliseconds: 500),
                          ),
                    ),

                    VisibilityDetector(
                      key: contactKey,
                      onVisibilityChanged: (info) {
                        setState(() {
                          anicotact = info.visibleFraction > 0;
                        });
                      },
                      child:
                          Container(
                            constraints: BoxConstraints(minHeight: 700),
                            alignment: Alignment.center,
                            child: const Contact(),
                          ).fadeInUp(
                            animate: anicotact,
                            duration: const Duration(milliseconds: 500),
                          ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.copyright, size: 23, color: primaryColor),
                        SizedBox(width: 5),
                        Text(
                          "2025 ",
                          style: TextStyle(
                            color: sectionColor,
                            fontSize: 19,
                            fontFamily: 'Rubic',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "made by ",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 19,
                            fontFamily: 'Rubic',
                          ),
                        ),
                        TextButton(

                          onPressed: () async {
                            if (await canLaunchUrl(Uri.parse(url))) {
                              await launchUrl(Uri.parse(url));
                            }
                          },
                          style: TextButton.styleFrom(
                            overlayColor:
                                Colors.transparent, 
                          ),
                          child: Text(
                            "Mohamed Abdullah ",
                            style: TextStyle(
                              color: sectionColor,
                              fontSize: 19,
                              fontFamily: 'Rubic',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

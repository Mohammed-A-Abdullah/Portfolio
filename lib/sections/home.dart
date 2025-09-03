import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:profolio/constant.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isHovered = false;
  bool isHoveredJob = false;
  bool isHoveredCV = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('home').snapshots(),
        builder: (context, homeSnapshot) {
          if (!homeSnapshot.hasData || homeSnapshot.data!.docs.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          final homeData = homeSnapshot.data!.docs.first;
          final profile = homeData['profile'];
          final title = homeData['title'];
          final job = homeData['job'];
          final cv = homeData['cv'];

          return LayoutBuilder(
            builder: (context, constraints) {
              bool isSmall = constraints.maxWidth < 750;

              return Flex(
                direction: isSmall ? Axis.vertical : Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      MouseRegion(
                        onEnter: (_) => setState(() => isHovered = true),
                        onExit: (_) => setState(() => isHovered = false),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: sectionColor,
                            boxShadow: [
                              BoxShadow(
                                color: const Color(
                                  0xFFFFEBD2,
                                ).withValues(alpha: 0.4),
                                blurRadius: 20,
                                spreadRadius: 5,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: ClipOval(
                            child: Stack(
                              children: [
                                Image.network(
                                  profile,
                                  width: 300,
                                  height: 300,
                                  fit: BoxFit.cover,
                                ),

                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut,
                                  width: 300,
                                  height: 300,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black.withValues(
                                      alpha: isHovered ? 0.7 : 0.0,
                                    ),
                                  ),
                                  child: AnimatedOpacity(
                                    opacity: isHovered ? 1.0 : 0.0,
                                    duration: const Duration(milliseconds: 400),
                                    curve: Curves.easeInOut,
                                    child: Center(
                                      child: StreamBuilder<QuerySnapshot>(
                                        stream: FirebaseFirestore.instance
                                            .collection('home')
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          if (!snapshot.hasData) {
                                            return const CircularProgressIndicator();
                                          }
                                          final docs = snapshot.data!.docs;
                                          return SingleChildScrollView(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: docs.map((data) {
                                                return Column(
                                                  children: [
                                                    const SelectableText(
                                                      "Information",
                                                      style: TextStyle(
                                                        color: sectionColor,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily: 'Rubic',
                                                      ),
                                                    ),
                                                    const SizedBox(height: 10),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        const Icon(
                                                          Icons.email,
                                                          color: sectionColor,
                                                          size: 16,
                                                        ),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        SelectableText(
                                                          data['email'],
                                                          style: const TextStyle(
                                                            color: primaryColor,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'PT_sans',
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        const Icon(
                                                          Icons.location_pin,
                                                          color: sectionColor,
                                                          size: 16,
                                                        ),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        SelectableText(
                                                          data['address'],
                                                          style: const TextStyle(
                                                            color: primaryColor,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'PT_sans',
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        const Icon(
                                                          Icons.phone,
                                                          color: sectionColor,
                                                          size: 16,
                                                        ),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        SelectableText(
                                                          data['phone'],
                                                          style: const TextStyle(
                                                            color: primaryColor,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'PT_sans',
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                );
                                              }).toList(),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 25),

                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('Links')
                            .snapshots(),
                        builder: (context, linkSnapshot) {
                          if (!linkSnapshot.hasData ||
                              linkSnapshot.data!.docs.isEmpty) {
                            return const CircularProgressIndicator();
                          }
                      
                          final docs = linkSnapshot.data!.docs;
                          return Wrap(
                        spacing: 10,
                        children: docs.map((doc) {
                          final image = doc['image'];
                          final url = doc['url'];
                          bool linkHovere = false;
                      
                          return StatefulBuilder(
                            builder: (context, setState) {
                              return MouseRegion(
                                onEnter: (_) => setState(() => linkHovere = true),
                                onExit: (_) => setState(() => linkHovere = false),
                                child: AnimatedScale(
                                  duration: const Duration(milliseconds: 100),
                                  scale: linkHovere ? 1.15 : 1.0,
                                  child: InkResponse(
                                    onTap: () async {
                                      if (await canLaunchUrl(Uri.parse(url))) {
                                        await launchUrl(Uri.parse(url));
                                      }
                                    },
                                    radius: 25,
                                    child: SvgPicture.string(
                                      image,
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                      colorFilter: linkHovere? ColorFilter.mode(
                                        sectionColor,
                                        BlendMode.srcIn,
                                      ): ColorFilter.mode(
                                                  primaryColor,
                                                  BlendMode.srcIn,
                                                ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      );
                      
                        },
                      ),
                    ],
                  ),

                  SizedBox(height: isSmall ? 30 : 0, width: isSmall ? 0 : 30),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MouseRegion(
                        onEnter: (_) => setState(() => isHovered = true),
                        onExit: (_) => setState(() => isHovered = false),
                        child: AnimatedScale(
                          duration: const Duration(milliseconds: 250),
                          scale: isHovered ? 1.2 : 1.0,
                          child: SelectableText(
                            title,
                            style: TextStyle(
                              fontSize: isSmall ? 24 : 30,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Rubic',
                              color: isHovered ? sectionColor : primaryColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),

                      MouseRegion(
                        onEnter: (_) => setState(() => isHoveredJob = true),
                        onExit: (_) => setState(() => isHoveredJob = false),
                        child: AnimatedScale(
                          duration: const Duration(milliseconds: 250),
                          scale: isHoveredJob ? 1.2 : 1.0,
                          child: SelectableText(
                            job,
                            style: TextStyle(
                              fontSize: isSmall ? 20 : 25,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Rubic',
                              color: isHoveredJob ? sectionColor : primaryColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      MouseRegion(
                        onEnter: (_) => setState(() => isHoveredCV = true),
                        onExit: (_) => setState(() => isHoveredCV = false),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          decoration: BoxDecoration(
                            color: isHoveredCV ? sectionColor : primaryColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              foregroundColor: isHoveredCV
                                  ? Colors.white
                                  : Colors.black,
                              shadowColor: Colors.transparent,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 15,
                              ),
                              textStyle: const TextStyle(fontSize: 20),
                            ),
                            onPressed: () async {
                              if (await canLaunchUrl(Uri.parse(cv))) {
                                await launchUrl(Uri.parse(cv));
                              }
                            },
                            label: const Text(
                              "Download CV",
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Rubic',
                              ),
                            ),
                            icon: AnimatedRotation(
                              turns: isHoveredCV ? 0.25 : 0,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              child: AnimatedScale(
                                scale: isHoveredCV ? 1.3 : 1.0,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                                child: const Icon(
                                  Icons.file_download_outlined,
                                  size: 25,
                                ),
                              ),
                            ),
                            iconAlignment: IconAlignment.end,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

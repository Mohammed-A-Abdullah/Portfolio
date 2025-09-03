import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:profolio/sections/skillCard/skill_item.dart';
import '../../constant.dart';

class SkillCard extends StatefulWidget {
  final String title;
  final String docId;
  final String icon;

  const SkillCard({
    super.key,
    required this.title,
    required this.docId,
    required this.icon,
  });

  @override
  State<SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<SkillCard> {
  bool isHovered = false;
  bool itemHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: SizedBox(
        width: 350,
        height: 350,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(
                color: isHovered ? sectionColor : primaryColor,
                width: 2,
              ),
            ),
            color: cardColor,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedScale(
                        scale: isHovered ? 1.1 : 1.0,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        child: CircleAvatar(
                          backgroundColor: isHovered
                              ? sectionColor
                              : Colors.transparent,
                          maxRadius: 30,
                          child: SvgPicture.string(
                            widget.icon,
                            width: 40,
                            fit: BoxFit.cover,
                            colorFilter: const ColorFilter.mode(
                              primaryColor,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      SelectableText(
                        textAlign: TextAlign.center,
                        widget.title,
                        style: const TextStyle(
                          fontSize: 30,
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Rubic',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('skills')
                          .doc(widget.docId)
                          .collection('data')
                          .snapshots(),
                      builder: (context, itemsSnapshot) {
                        if (!itemsSnapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        final items = itemsSnapshot.data!.docs;

                        if (items.isEmpty) {
                          return const Center(
                            child: SelectableText(
                              "No data available",
                              style: TextStyle(color: primaryColor),
                            ),
                          );
                        }

                        return SingleChildScrollView(
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 10,
                            runSpacing: 10,
                            children: items.map((item) {
                              return SkillItem(text: item['content']);
                            }).toList(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

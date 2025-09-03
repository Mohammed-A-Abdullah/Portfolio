import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:profolio/constant.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> with TickerProviderStateMixin {
  bool isHovered = false;
  static const double _minContentHeight = 80;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(width: 10),
          Center(
            child: SelectableText(
              'About Me',
              style: TextStyle(
                fontSize: 35,
                fontFamily: 'Rubic',
                fontWeight: FontWeight.bold,
                color: sectionColor,
              ),
            ),
          ),
          const SizedBox(height: 20),

          MouseRegion(
            onEnter: (_) => setState(() => isHovered = true),
            onExit: (_) => setState(() => isHovered = false),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isHovered ? sectionColor : primaryColor,
                  width: 2,
                ),
                boxShadow: [
                  if (isHovered)
                    BoxShadow(
                      color: sectionColor.withOpacity(0.25), 
                      blurRadius: 15,
                      spreadRadius: 2,
                      offset: const Offset(0, 6),
                    ),
                ],
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final double maxTextWidth = constraints.maxWidth > 600
                      ? 600
                      : constraints.maxWidth;

                  return StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('about')
                        .snapshots(),
                    builder: (context, snapshot) {
                      final bool hasData =
                          snapshot.hasData && snapshot.data!.docs.isNotEmpty;
                      final String text = hasData
                          ? (snapshot.data!.docs.first['aboutme'] as String? ??
                                '')
                          : '';

                      return AnimatedSize(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeInOut,
                        alignment: Alignment.topCenter,
                        clipBehavior: Clip.none,
              
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight:
                                _minContentHeight,
                            maxWidth: maxTextWidth,
                          ),
                          child: Stack(
                            children: [
                              hasData
                                  ? SelectableText(
                                      text,
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: contentColor,
                                        fontFamily: 'PT_sans',
                                        height: 1.6,
                                      ),
                                    )
                                  : const _SkeletonPlaceholder(),

                              // نعرض الـspinner فوق المحتوى بدون تغيير المقاس
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting)
                                const Positioned.fill(
                                  child: IgnorePointer(
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 60),
        ],
      ),
    );
  }
}

class _SkeletonPlaceholder extends StatelessWidget {
  const _SkeletonPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        _SkeletonLine(widthFactor: 0.95),
        SizedBox(height: 10),
        _SkeletonLine(widthFactor: 1.0),
        SizedBox(height: 10),
        _SkeletonLine(widthFactor: 0.9),
        SizedBox(height: 10),
        _SkeletonLine(widthFactor: 0.6),
      ],
    );
  }
}

class _SkeletonLine extends StatelessWidget {
  final double widthFactor;
  const _SkeletonLine({required this.widthFactor});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: widthFactor,
      child: Container(
        height: 16,
        decoration: BoxDecoration(
          color: contentColor.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }
}

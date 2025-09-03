import 'package:flutter/material.dart';
import 'package:profolio/constant.dart';

class SkillItem extends StatefulWidget {
  final String text;

  const SkillItem({super.key, required this.text});

  @override
  State<SkillItem> createState() => _SkillItemState();
}

class _SkillItemState extends State<SkillItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isHovered
              ? backgroundColor.withValues(alpha:  0.3)
              : Colors.transparent,
          border: Border.all(color: isHovered ? sectionColor : primaryColor),
        ),
        child: SelectableText(
          widget.text,
          style: const TextStyle(
            fontSize: 14,
            color: primaryColor,
            fontFamily: 'PT_sans',
          ),
        ),
      ),
    );
  }
}

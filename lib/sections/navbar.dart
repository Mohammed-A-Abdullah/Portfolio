import 'package:flutter/material.dart';
import 'package:profolio/constant.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key, required this.onNavClick, required this.keysMap});

  final Function(GlobalKey) onNavClick;
  final Map<String, GlobalKey> keysMap;

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  Widget _navButton(String text, VoidCallback onTap) {
    bool isHovered = false;

    return StatefulBuilder(
      builder: (context, setState) {
        return MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: isHovered ? sectionColor : primaryColor,
                padding: EdgeInsets.zero,
                overlayColor: Colors.transparent,
              ),
              onPressed: onTap,
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                    child: AnimatedScale(
                      duration: const Duration(milliseconds: 250),
                      scale: isHovered ? 1.3 : 1.0,
                      child: Text(
                        text,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Rubic',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 70,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 400),
                        height: 2,
                        width: isHovered ? 75 : 0,
                        color: isHovered ? sectionColor : primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: LayoutBuilder(
        builder: (context, constraints) {
          bool isSmallScreen = constraints.maxWidth < 750;

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SelectableText.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '<',
                      style: TextStyle(
                        color: Color(0xFFFFEBD2),
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Rubic',
                      ),
                    ),
                    TextSpan(
                      text: ' Mohamed Abdullah ',
                      style: TextStyle(
                        color: sectionColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Rubic',
                      ),
                    ),
                    TextSpan(
                      text: '>',
                      style: TextStyle(
                        color: Color(0xFFFFEBD2),
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Rubic',
                      ),
                    ),
                  ],
                ),
              ),

             
              if (!isSmallScreen)
                Row(
                  children: widget.keysMap.entries.map((entry) {
                    return Row(
                      
                      children: [
                        _navButton(
                          entry.key,
                          () => widget.onNavClick(entry.value),
                        ),
                        const SizedBox(width: 20),
                      ],
                    );
                  }).toList(),
                )
              else
                Builder(
                  builder: (context) => IconButton(
                    icon: const Icon(Icons.menu, color: sectionColor, size: 28),
                    onPressed: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

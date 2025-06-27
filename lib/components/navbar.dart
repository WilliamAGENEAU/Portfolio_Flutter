import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  final List<String> menuItems;
  final int selectedIndex;
  final Function(int) onMenuTap;

  const Navbar({
    super.key,
    required this.menuItems,
    required this.selectedIndex,
    required this.onMenuTap,
  });

  @override
  Widget build(BuildContext context) {
    final black = const Color(0xFF181818);
    return LayoutBuilder(
      builder: (context, constraints) {
        // Largeur totale de l'appbar
        final totalWidth = constraints.maxWidth;
        // Largeur estimée du menu (ajuste si besoin)
        const menuWidth = 500.0;
        // Padding entre la ligne et le menu
        const lineMenuPadding = 32.0;
        // Largeur de la ligne
        final lineWidth = totalWidth - menuWidth - lineMenuPadding;

        return Container(
          color: const Color(0xFFFFF6EB),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          alignment: Alignment.centerLeft,
          child: Stack(
            children: [
              // Ligne noire responsive
              Positioned(
                left: 0,
                top: 30,
                child: Container(
                  width: lineWidth > 0 ? lineWidth : 0,
                  height: 1,
                  color: Colors.black,
                ),
              ),
              Positioned(
                left: 20, // Décale la ligne pour ne pas coller au bord
                top: 0,
                bottom: 0,
                child: Container(width: 1, color: Colors.black),
              ),
              // Menu
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(menuItems.length, (i) {
                    final isActive = selectedIndex == i;
                    final Widget button = i == 3
                        ? ElevatedButton(
                            onPressed: () => onMenuTap(i),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isActive
                                  ? black
                                  : Colors.transparent,
                              foregroundColor: isActive ? Colors.white : black,
                              elevation: 0,
                              side: isActive
                                  ? BorderSide(color: black, width: 2)
                                  : BorderSide.none,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              menuItems[i],
                              style: TextStyle(
                                color: isActive ? Colors.white : black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : TextButton(
                            onPressed: () => onMenuTap(i),
                            style: TextButton.styleFrom(
                              backgroundColor: isActive
                                  ? black
                                  : Colors.transparent,
                              foregroundColor: isActive ? Colors.white : black,
                              side: isActive
                                  ? BorderSide(color: black, width: 2)
                                  : BorderSide.none,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                            ),
                            child: Text(
                              menuItems[i],
                              style: TextStyle(
                                color: isActive ? Colors.white : black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                    return Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: button,
                    );
                  }),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

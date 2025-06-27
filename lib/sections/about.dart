import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Ligne verticale noire à gauche (sur toute la hauteur)

        // Fond uni blanc cassé
        Container(
          width: double.infinity,
          height: double.infinity,
          color: const Color(0xFFFFF6EB),
        ),
        Positioned(
          left: 44, // Décale la ligne pour ne pas coller au bord
          top: 0,
          bottom: 0,
          child: Container(width: 1, color: Colors.black),
        ),
        // Flèche noire en haut pointant vers le coin gauche haut
        Positioned(
          left: 44,

          child: Transform.rotate(
            angle: -0.75, // Légère rotation pour pointer vers le coin
            child: Icon(Icons.arrow_upward, color: Colors.black, size: 66),
          ),
        ),
        // Contenu principal
        Row(
          children: [
            // Décale le contenu pour ne pas coller à la ligne verticale
            const SizedBox(width: 90),
            // Partie gauche : titre et sous-titre centrés verticalement
            Expanded(
              flex: 2,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hi, I'm",
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    Text(
                      "William Ageneau",
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "UX/UI designer engineer",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              child: Container(width: 1, color: Colors.black, height: 500),
            ),
            // Partie droite : photo très grande, sans cercle ni bordure
            Expanded(
              flex: 3,
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: const EdgeInsets.only(right: 32),
                  width: 700,
                  height: 700,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(350),
                    child: Image.asset(
                      'assets/images/william_bkg.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

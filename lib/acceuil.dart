import 'package:flutter/material.dart';

class Accueil extends StatelessWidget {
  const Accueil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Image.asset(
                'images/william_bkg.png', // Assurez-vous que l'image est dans le dossier assets
                fit: BoxFit.contain,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                'William Ageneau',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Accueil extends StatelessWidget {
  const Accueil({super.key});

  Future<void> _openResume(BuildContext context) async {
    final url = Uri.parse('assets/resume.pdf');
    if (!await launchUrl(url, webOnlyWindowName: '_blank')) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error opening the resume.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Container(
          color: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  // Naviguer vers About me
                },
                child: const Text('About me'),
              ),
              const SizedBox(width: 16),
              TextButton(
                onPressed: () {
                  // Naviguer vers Projects
                },
                child: const Text('Projects'),
              ),
              const SizedBox(width: 16),
              TextButton(
                onPressed: () {
                  // Naviguer vers Contact
                },
                child: const Text('Contact'),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () => _openResume(context),
                child: const Text('Resume'),
              ),
            ],
          ),
        ),
      ),
      body: Row(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Image.asset('images/william_bkg.png', fit: BoxFit.contain),
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

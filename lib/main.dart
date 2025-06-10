import 'package:flutter/material.dart';
import 'about.dart';
import 'projects.dart';
import 'contact.dart';
import 'resume_section.dart';
import 'package:url_launcher/url_launcher.dart';
import 'util.dart';
import 'theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;

    TextTheme textTheme = createTextTheme(
      context,
      "Open Sans",
      "Share Tech Mono",
    );

    MaterialTheme theme = MaterialTheme(textTheme);
    return MaterialApp(
      title: 'William AGENEAU',
      debugShowCheckedModeBanner: false,
      theme: brightness == Brightness.light ? theme.dark() : theme.light(),

      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scrollController = ScrollController();
  final aboutKey = GlobalKey();
  final projectsKey = GlobalKey();
  final contactKey = GlobalKey();
  final resumeKey = GlobalKey();

  int selectedIndex = 0;

  final sectionTitles = ['About me', 'Projects', 'Contact', 'Resume'];

  void scrollToSection(int index) {
    final contextMap = [
      aboutKey.currentContext,
      projectsKey.currentContext,
      contactKey.currentContext,
      resumeKey.currentContext,
    ];
    final ctx = contextMap[index];
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      setState(() {
        selectedIndex = index;
      });
    }
  }

  void _openResumePdf() async {
    final url = Uri.parse('assets/resume.pdf');
    await launchUrl(url, webOnlyWindowName: '_blank');
  }

  void _onMenuTap(int index) {
    if (index == 3) {
      _openResumePdf();
    } else {
      scrollToSection(index);
    }
  }

  void _onScroll() {
    final positions = [aboutKey, projectsKey, contactKey, resumeKey].map((key) {
      final ctx = key.currentContext;
      if (ctx == null) return double.infinity;
      final box = ctx.findRenderObject() as RenderBox;
      return box.localToGlobal(Offset.zero).dy.abs();
    }).toList();

    final minIndex = positions.indexOf(
      positions.reduce((a, b) => a < b ? a : b),
    );
    if (selectedIndex != minIndex && minIndex != 3) {
      setState(() {
        selectedIndex = minIndex;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final menuItems = ['About me', 'Projects', 'Contact', 'Resume'];
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Largeur totale de l'appbar
            final totalWidth = constraints.maxWidth;
            // Largeur estimée du menu (ajuste si besoin)
            const menuWidth = 500.0;
            // Padding entre la ligne et le menu
            const lineMenuPadding = 32.0;
            // Largeur de la lign
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
                        final black = const Color(0xFF181818);
                        final Widget button = i == 3
                            ? ElevatedButton(
                                onPressed: () => _onMenuTap(i),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  foregroundColor: black,
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
                                    color: black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            : TextButton(
                                onPressed: () => _onMenuTap(i),
                                style: TextButton.styleFrom(
                                  foregroundColor: black,
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
                                    color: black,
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
        ),
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            Container(
              key: aboutKey,
              height: MediaQuery.of(context).size.height,
              child: const About(),
            ),
            Container(
              key: projectsKey,
              height: MediaQuery.of(context).size.height,
              child: const Projects(),
            ),
            Container(
              key: contactKey,
              height: MediaQuery.of(context).size.height,
              child: const Contact(),
            ),
            Container(
              key: resumeKey,
              height: MediaQuery.of(context).size.height,
              child: const ResumeSection(),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:portfolio_flutter/components/navbar.dart';
import 'about.dart';
import 'projects.dart';
import 'contact.dart';
import 'resume_section.dart';
import 'package:url_launcher/url_launcher.dart';

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
        child: Navbar(
          menuItems: menuItems,
          selectedIndex: selectedIndex,
          onMenuTap: _onMenuTap,
        ),
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            SizedBox(
              key: aboutKey,
              height: MediaQuery.of(context).size.height,
              child: const About(),
            ),
            SizedBox(
              key: projectsKey,
              height: MediaQuery.of(context).size.height,
              child: const Projects(),
            ),
            SizedBox(
              key: contactKey,
              height: MediaQuery.of(context).size.height,
              child: const Contact(),
            ),
            SizedBox(
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

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class AboutSection extends StatefulWidget {
  const AboutSection({super.key});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildAnimatedPoint({
    required String title,
    required String text,
    required String imagePath,
    required bool isImageLeft,
    required int index,
    required BuildContext context,
  }) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    final screenWidth = MediaQuery.of(context).size.width;

    final image = AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final start = index * 0.15;
        final end = start + 0.7;
        final progress = ((_controller.value - start) / (end - start)).clamp(
          0.0,
          1.0,
        );

        return Transform.scale(
          scale: 0.85 + (0.15 * progress),
          child: Opacity(opacity: progress, child: child),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(isMobile ? 24 : 32),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              offset: const Offset(0, 15),
              blurRadius: 35,
              spreadRadius: -5,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(isMobile ? 24 : 32),
          child: Image.asset(
            imagePath,
            width: isMobile ? screenWidth * 0.85 : 340,
            height: isMobile ? screenWidth * 0.95 : 380,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );

    final content = AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final start = index * 0.15 + 0.1;
        final end = start + 0.7;
        final progress = ((_controller.value - start) / (end - start)).clamp(
          0.0,
          1.0,
        );

        return Opacity(
          opacity: progress,
          child: Transform.translate(
            offset: Offset(0, 30 * (1 - progress)),
            child: child,
          ),
        );
      },
      child: Column(
        crossAxisAlignment: isMobile
            ? CrossAxisAlignment.center
            : (isImageLeft ? CrossAxisAlignment.start : CrossAxisAlignment.end),
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: isMobile ? 28 : 32,
              fontWeight: FontWeight.w800,
              fontFamily: 'Montserrat',
              color: Colors.white,
              letterSpacing: -0.5,
            ),
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
          ),
          SizedBox(height: isMobile ? 16 : 20),
          Container(
            constraints: BoxConstraints(
              maxWidth: isMobile ? screenWidth * 0.85 : 480,
            ),
            child: Text(
              text,
              style: TextStyle(
                fontSize: isMobile ? 15 : 17,
                fontFamily: 'Montserrat',
                height: 1.7,
                color: Colors.white.withOpacity(0.9),
                fontWeight: FontWeight.w400,
              ),
              textAlign: isMobile ? TextAlign.center : TextAlign.justify,
            ),
          ),
        ],
      ),
    );

    if (isMobile) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [image, const SizedBox(height: 28), content],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: isImageLeft
                ? [image, const SizedBox(width: 60), Expanded(child: content)]
                : [Expanded(child: content), const SizedBox(width: 60), image],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    return Container(
      color: const Color(0xff171014),
      width: double.infinity,
      child: VisibilityDetector(
        key: const Key("about-section"),
        onVisibilityChanged: (info) {
          if (info.visibleFraction > 0.2 && !_controller.isAnimating) {
            _controller.forward();
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: isMobile ? 40 : 80),

            // Titre de section avec animation
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeOut,
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform.translate(
                    offset: Offset(0, 20 * (1 - value)),
                    child: child,
                  ),
                );
              },
              child: Column(
                children: [
                  Text(
                    "À PROPOS",
                    style: TextStyle(
                      fontSize: isMobile ? 14 : 16,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Montserrat',
                      color: Colors.white.withOpacity(0.6),
                      letterSpacing: 3,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: 60,
                    height: 3,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: isMobile ? 30 : 50),

            _buildAnimatedPoint(
              title: "Qui suis-je ?",
              text:
                  "Je suis ingénieur logiciel front-end passionné par la création d'applications de haute qualité. Je suis diplômé ingénieur informatique de l'école d'ingénieurs ESAIP d'Angers, avec une spécialisation en IoT (objets connectés). Je possède de solides compétences techniques ainsi que d'excellentes aptitudes relationnelles, qui m'ont permis de travailler et d'interagir avec des clients partout dans le monde. Après mes études, je suis parti en voyage dans les Balkans en Van pour développer mes projets personnels et découvrir de nouvelles cultures.",
              imagePath: "assets/images/story6.jpg",
              isImageLeft: false,
              index: 0,
              context: context,
            ),

            _buildAnimatedPoint(
              title: "La musique",
              text:
                  "Je suis également DJ passionné de musique électronique, ce qui me permet d'allier créativité et technologie de manière unique.",
              imagePath: "assets/images/story1.jpg",
              isImageLeft: true,
              index: 1,
              context: context,
            ),

            _buildAnimatedPoint(
              title: "UX / UI & Problèmes",
              text:
                  "Je suis très doué pour réfléchir et résoudre des problèmes à l'aide d'interfaces informatiques intelligentes, intuitives et modernes. Je m'oriente de plus en plus vers l'expérience utilisateur et le design (UX/UI).",
              imagePath: "assets/images/willboss.jpg",
              isImageLeft: false,
              index: 2,
              context: context,
            ),

            SizedBox(height: isMobile ? 40 : 80),
          ],
        ),
      ),
    );
  }
}

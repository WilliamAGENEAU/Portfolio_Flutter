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
      duration: const Duration(milliseconds: 1200),
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

    final image = ClipRRect(
      borderRadius: BorderRadius.circular(40), // forme organique
      child: Image.asset(
        imagePath,
        width: isMobile ? 240 : 320,
        height: isMobile ? 260 : 350,
        fit: BoxFit.cover,
      ),
    );

    final content = Flexible(
      child: Column(
        crossAxisAlignment: isMobile
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
              color: Colors.white,
            ),
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
          ),
          const SizedBox(height: 12),
          Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'Montserrat',
              height: 1.6,
              color: Colors.white,
            ),
            textAlign: TextAlign.justify, // ✅ texte justifié
          ),
        ],
      ),
    );

    final child = isMobile
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [image, const SizedBox(height: 20), content],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: isImageLeft
                ? [image, const SizedBox(width: 40), content]
                : [content, const SizedBox(width: 40), image],
          );

    // ✅ Animation contrôlée par VisibilityDetector
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, childWidget) {
        final start = index * 0.2;
        final end = start + 0.6;
        final progress = ((_controller.value - start) / (end - start)).clamp(
          0.0,
          1.0,
        );

        return Opacity(
          opacity: progress, // ✅ opacité animée
          child: Transform.translate(
            offset: Offset(0, 50 * (1 - progress)),
            child: childWidget,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff171014), // ✅ fond sombre
      width: double.infinity,
      child: VisibilityDetector(
        key: const Key("about-section"),
        onVisibilityChanged: (info) {
          if (info.visibleFraction > 0.25) {
            _controller.forward();
          }
        },
        child: Column(
          children: [
            _buildAnimatedPoint(
              title: "Qui suis-je ?",
              text:
                  "Je suis ingénieur logiciel front-end passionné par la création d'applications de haute qualité. Je suis diplômé ingénieur informatique de l'école d'ingénieurs ESAIP d'Angers, avec une spécialisation en IoT (objets connectés). Je possède de solides compétences techniques ainsi que d'excellentes aptitudes relationnelles, qui m'ont permis de travailler et d'interagir avec des clients partout dans le monde.",
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
          ],
        ),
      ),
    );
  }
}

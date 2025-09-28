import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../values/values.dart';

class TechnologySection extends StatelessWidget {
  const TechnologySection({
    super.key,
    required this.controller,
    required this.width,
  });

  final AnimationController controller;
  final double width;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    final titleStyle = textTheme.headlineSmall?.copyWith(
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );

    final itemStyle = textTheme.bodyMedium?.copyWith(
      fontSize: Sizes.TEXT_SIZE_15,
      color: Colors.white,
      fontWeight: FontWeight.w400,
      height: 1.6,
    );

    // ✅ Listes comme dans ton image
    final webMobileLogiciel1 = [
      "Flutter",
      "HTML 5",
      "CSS 3",
      "Python",
      "JavaScript",
      "React JS",
      "Node JS",
      "Git",
      "Google Cloud",
      "PHP",
      "Azure",
    ];

    final webMobileLogiciel2 = [
      "SQL",
      "Embedded C/C++",
      "Firebase",
      "Wordpress",
      "Machine Learning",
      "Development .NET",
      "Edge computing",
      "Bluetooth",
      "Zigbee",
      "LoRa",
    ];

    final uxUi = [
      "Figma",
      "UX Research",
      "Chakra UI",
      "Wireframing",
      "Blender",
      "Resolume",
    ];

    return Container(
      color: const Color(0xff171014), // ✅ même fond que AboutSection
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      child: ResponsiveBuilder(
        builder: (context, sizingInformation) {
          bool isMobile =
              sizingInformation.screenSize.width <
              RefinedBreakpoints().tabletNormal;

          if (isMobile) {
            // ✅ Mobile = tout en colonne
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildCategory(
                  "Web / Mobile / Logiciel",
                  [webMobileLogiciel1, webMobileLogiciel2],
                  titleStyle!,
                  itemStyle!,
                  isMobile: true,
                ),
                const SizedBox(height: 40),
                _buildCategory(
                  "UX/UI",
                  [uxUi],
                  titleStyle,
                  itemStyle,
                  isMobile: true,
                ),
              ],
            );
          }

          // ✅ Desktop = deux grandes colonnes
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1000),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Colonne gauche
                  Expanded(
                    flex: 2,
                    child: _buildCategory(
                      "Web / Mobile / Logiciel",
                      [webMobileLogiciel1, webMobileLogiciel2],
                      titleStyle!,
                      itemStyle!,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    width: 1,
                    color: Colors.white.withOpacity(
                      0.6,
                    ), // ✅ séparateur vertical
                  ),
                  // Colonne droite
                  Expanded(
                    flex: 1,
                    child: _buildCategory(
                      "UX/UI",
                      [uxUi],
                      titleStyle,
                      itemStyle,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategory(
    String title,
    List<List<String>> lists,
    TextStyle titleStyle,
    TextStyle itemStyle, {
    bool isMobile = false,
  }) {
    return Column(
      crossAxisAlignment: isMobile
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Text(title, style: titleStyle),
        const SizedBox(height: 20),
        isMobile
            ? Column(
                children: lists
                    .map((list) => _buildList(list, itemStyle))
                    .toList(),
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: lists
                    .map((list) => Expanded(child: _buildList(list, itemStyle)))
                    .toList(),
              ),
      ],
    );
  }

  Widget _buildList(List<String> items, TextStyle style) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items
          .map(
            (e) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  const Text(
                    "• ",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Expanded(child: Text(e, style: style)),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:portfolio_flutter/widgets/spaces.dart';

import '../core/adaptive.dart';
import '../core/functions.dart';
import '../values/values.dart';
import 'animated_bubble_button.dart';
import 'animated_positioned_text.dart';
import 'animated_positioned_widget.dart';
import 'animated_text_slide_box_transition.dart';
import 'empty.dart';
import 'project_item.dart';

List<String> titles = [
  StringConst.PLATFORM,
  StringConst.CATEGORY,
  StringConst.AUTHOR,
  StringConst.DESIGNER,
  StringConst.TECHNOLOGY_USED,
];

class Aboutproject extends StatefulWidget {
  const Aboutproject({
    super.key,
    required this.controller,
    required this.projectDataController,
    required this.projectData,
    required this.width,
  });

  final AnimationController controller;
  final AnimationController projectDataController;
  final ProjectItemData projectData;
  final double width;

  @override
  _AboutprojectState createState() => _AboutprojectState();
}

class _AboutprojectState extends State<Aboutproject> {
  @override
  void initState() {
    super.initState();

    widget.controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.projectDataController.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double targetWidth = responsiveSize(context, 118, 150, md: 150);
    double initialWidth = responsiveSize(context, 36, 50, md: 50);
    TextTheme textTheme = Theme.of(context).textTheme;

    // ✅ Styles adaptés
    TextStyle? bodyTextStyle = textTheme.bodyMedium?.copyWith(
      fontSize: Sizes.TEXT_SIZE_18,
      color: Colors.white, // blanc
      fontWeight: FontWeight.w400,
      height: 2.0,
    );

    double projectDataWidth = responsiveSize(
      context,
      widget.width,
      widget.width * 0.55,
      md: widget.width * 0.75,
    );
    double projectDataSpacing = responsiveSize(
      context,
      widget.width * 0.1,
      48,
      md: 36,
    );
    double widthOfProjectItem = (projectDataWidth - (projectDataSpacing)) / 2;
    BorderRadiusGeometry borderRadius = BorderRadius.all(
      Radius.circular(100.0),
    );

    TextStyle? buttonStyle = textTheme.bodyMedium?.copyWith(
      color: Colors.black,
      fontSize: responsiveSize(
        context,
        Sizes.TEXT_SIZE_8,
        Sizes.TEXT_SIZE_10,
        sm: Sizes.TEXT_SIZE_10,
      ),
      fontWeight: FontWeight.w500,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ✅ Titre simple, en blanc
        Text(
          StringConst.ABOUT_PROJECT,
          style: textTheme.bodyLarge?.copyWith(
            fontSize: Sizes.TEXT_SIZE_48,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        SpaceH40(),
        // ✅ Description
        AnimatedPositionedText(
          controller: CurvedAnimation(
            parent: widget.controller,
            curve: Animations.textSlideInCurve,
          ),
          width: widget.width * 0.7,
          maxLines: 10,
          text: widget.projectData.portfolioDescription,
          textStyle: bodyTextStyle,
        ),
        SpaceH40(),
        // ✅ Données principales
        SizedBox(
          width: projectDataWidth,
          child: Wrap(
            spacing: projectDataSpacing,
            runSpacing: responsiveSize(context, 30, 40),
            children: [
              if (widget.projectData.platform != null)
                ProjectData(
                  controller: widget.projectDataController,
                  width: widthOfProjectItem,
                  title: "Plateforme",
                  subtitle: widget.projectData.platform!,
                ),
              ProjectData(
                controller: widget.projectDataController,
                width: widthOfProjectItem,
                title: "Catégorie",
                subtitle: widget.projectData.category,
              ),
              if (widget.projectData.entreprise != null)
                ProjectData(
                  controller: widget.projectDataController,
                  width: widthOfProjectItem,
                  title: "Entreprise",
                  subtitle: widget.projectData.entreprise!,
                ),
              if (widget.projectData.domaine != null)
                ProjectData(
                  controller: widget.projectDataController,
                  width: widthOfProjectItem,
                  title: "Domaine",
                  subtitle: widget.projectData.domaine!,
                ),
            ],
          ),
        ),

        widget.projectData.designer != null ? SpaceH30() : Empty(),
        widget.projectData.designer != null
            ? ProjectData(
                controller: widget.projectDataController,
                title: "Designer",
                subtitle: widget.projectData.designer!,
              )
            : Empty(),

        widget.projectData.technologyUsed != null ? SpaceH30() : Empty(),
        widget.projectData.technologyUsed != null
            ? ProjectData(
                controller: widget.projectDataController,
                title: "Technologies utilisées",
                subtitle: widget.projectData.technologyUsed!,
              )
            : Empty(),

        SpaceH30(),

        // ✅ Boutons Live / GitHub
        Row(
          children: [
            widget.projectData.isLive
                ? AnimatedPositionedWidget(
                    controller: CurvedAnimation(
                      parent: widget.projectDataController,
                      curve: Animations.textSlideInCurve,
                    ),
                    width: targetWidth,
                    height: initialWidth,
                    child: AnimatedBubbleButton(
                      title: StringConst.LAUNCH_APP,
                      color: Colors.white,
                      imageColor: Colors.black,
                      startBorderRadius: borderRadius,
                      startWidth: initialWidth,
                      height: initialWidth,
                      targetWidth: targetWidth,
                      titleStyle: buttonStyle,
                      onTap: () {
                        Functions.launchUrl(widget.projectData.webUrl);
                      },
                      startOffset: const Offset(0, 0),
                      targetOffset: const Offset(0.1, 0),
                    ),
                  )
                : Empty(),
            widget.projectData.isLive ? Spacer() : Empty(),
            widget.projectData.isPublic
                ? AnimatedPositionedWidget(
                    controller: CurvedAnimation(
                      parent: widget.projectDataController,
                      curve: Animations.textSlideInCurve,
                    ),
                    width: targetWidth,
                    height: initialWidth,
                    child: AnimatedBubbleButton(
                      title: StringConst.SOURCE_CODE.toUpperCase(),
                      onTap: () {
                        Functions.launchUrl(widget.projectData.gitHubUrl);
                      },
                    ),
                  )
                : Empty(),
          ],
        ),

        widget.projectData.isPublic || widget.projectData.isLive
            ? SpaceH30()
            : Empty(),
      ],
    );
  }
}

class ProjectData extends StatelessWidget {
  const ProjectData({
    super.key,
    required this.title,
    required this.subtitle,
    required this.controller,
    this.width = double.infinity,
    this.titleStyle,
    this.subtitleStyle,
  });

  final String title;
  final String subtitle;
  final double width;
  final AnimationController controller;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    // ✅ Styles en blanc
    TextStyle? defaultTitleStyle = textTheme.bodySmall?.copyWith(
      color: Colors.white,
      fontSize: 17,
      fontWeight: FontWeight.bold,
    );

    TextStyle? defaultSubtitleStyle = textTheme.bodySmall?.copyWith(
      fontSize: 15,
      color: Colors.white,
    );

    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // ✅ Animation conservée mais sans surlignage blanc
          AnimatedTextSlideBoxTransition(
            width: width,
            maxLines: 2,
            controller: controller,
            text: title,
            textStyle: titleStyle ?? defaultTitleStyle,
            color: Colors.transparent, // enlève le surlignage
            coverColor: Colors.transparent, // idem
          ),
          SpaceH12(),
          AnimatedPositionedText(
            width: width,
            maxLines: 2,
            controller: CurvedAnimation(
              parent: controller,
              curve: Animations.textSlideInCurve,
            ),
            text: subtitle,
            textStyle: subtitleStyle ?? defaultSubtitleStyle,
          ),
        ],
      ),
    );
  }
}

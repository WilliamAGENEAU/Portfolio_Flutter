// ignore_for_file: library_private_types_in_public_api, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:portfolio_flutter/widgets/animated_bubble_button.dart';
import 'package:portfolio_flutter/widgets/spaces.dart';

import '../core/adaptive.dart';
import '../values/values.dart';

class ProjectItemData {
  ProjectItemData({
    required this.title,
    required this.image,
    required this.coverUrl,
    required this.subtitle,
    required this.portfolioDescription,
    required this.platform,
    required this.primaryColor,
    required this.category,
    this.designer,
    this.projectAssets = const [],
    this.imageSize,
    this.technologyUsed,
    this.isPublic = false,
    this.isOnPlayStore = false,
    this.isLive = false,
    this.gitHubUrl = "",
    this.hasBeenReleased = true,
    this.playStoreUrl = "",
    this.webUrl = "",
    this.navTitleColor = AppColors.grey600,
    this.navSelectedTitleColor = AppColors.black,
    this.appLogoColor = AppColors.black,
  });

  final Color primaryColor;
  final Color navTitleColor;
  final Color navSelectedTitleColor;
  final Color appLogoColor;
  final String image;
  final String coverUrl;
  final String category;
  final List<String> projectAssets;
  final String portfolioDescription;
  final double? imageSize;
  final String title;
  final String subtitle;
  final String platform;
  final String? designer;
  final bool isPublic;
  final bool hasBeenReleased;
  final String gitHubUrl;
  final bool isOnPlayStore;
  final String playStoreUrl;
  final bool isLive;
  final String webUrl;
  final String? technologyUsed;
}

class ProjectData extends StatelessWidget {
  const ProjectData({
    super.key,
    required this.projectNumber,
    required this.title,
    required this.subtitle,
    required this.duration,
    this.curve = Curves.ease,
    this.projectNumberStyle,
    this.subtitleStyle,
    this.titleStyle,
    this.indicatorColor = AppColors.grey550,
    this.indicatorHeight = Sizes.HEIGHT_1,
    this.indicatorWidth = Sizes.WIDTH_150,
    this.indicatorMargin,
    this.leadingMargin,
  });

  final String projectNumber;
  final String title;
  final String subtitle;
  final Color indicatorColor;
  final TextStyle? projectNumberStyle;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final double indicatorWidth;
  final double indicatorHeight;
  final EdgeInsetsGeometry? indicatorMargin;
  final EdgeInsetsGeometry? leadingMargin;
  final Duration duration;
  final Curve curve;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: leadingMargin,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedContainer(
                width: indicatorWidth,
                height: indicatorHeight,
                margin: indicatorMargin,
                color: indicatorColor,
                duration: duration,
                curve: curve,
              ),
              SpaceW4(),
              Text(projectNumber, style: projectNumberStyle),
            ],
          ),
        ),
        SpaceW30(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: titleStyle),
            SpaceH16(),
            Text(subtitle, style: subtitleStyle),
          ],
        ),
      ],
    );
  }
}

// For rendering on bigger devices eg. tablets, desktops etc.
const double startWidthOfButton = 54;
const double heightOfButton = startWidthOfButton;
const double targetWidthOfButton = 200;
const double startWidthOfButtonMd = 44;
const double heightOfButtonMd = startWidthOfButtonMd;
const double targetWidthOfButtonMd = 160;

// For rendering on mobile devices
const double startWidthOfButtonSm = 40;
const double targetWidthSm = 160;
const double heightOfButtonSm = startWidthOfButtonSm;

class ProjectItemLg extends StatefulWidget {
  const ProjectItemLg({
    super.key,
    required this.projectNumber,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.containerColor,
    this.projectItemheight,
    this.subheight,
    this.coloredContainerHeight,
    this.coloredContainerWidth,
    this.buttonTitle = StringConst.VIEW,
    this.backgroundOnHoverColor = const Color(0xFF232323), // gris/noir foncé
    this.backgroundColor = Colors.black, // fond noir par défaut
    this.projectNumberStyle,
    this.subtitleStyle,
    this.titleStyle,
    this.duration = const Duration(milliseconds: 300),
    this.padding,
    this.onTap,
  });

  /// signifies the position of the project in the list
  final String projectNumber;

  /// text for the title of project (usually states the project name)
  final String title;

  /// text for the subtitle of project (usually describes the project or states the platform)
  final String subtitle;

  /// url or location for project image or cover
  final String imageUrl;

  /// text that shows on the button (defaults to view project)
  final String buttonTitle;

  /// style for the project number (signifies the position of the project in the list)
  final TextStyle? projectNumberStyle;

  /// style for the title
  final TextStyle? titleStyle;

  /// style for the subtitle
  final TextStyle? subtitleStyle;

  /// color of the container under the project item image. mostly contains the primary color used in the project
  final Color containerColor;

  /// initial background color of the project item
  final Color backgroundColor;

  /// background color of the project item when it is hovered on
  final Color backgroundOnHoverColor;
  final Duration duration;

  /// full height of the project item
  final double? projectItemheight;

  /// height of the portion that contains the title, subtitle and button
  final double? subheight;

  /// height of the colored container under the project image cover
  final double? coloredContainerWidth;

  /// width of the colored container under the project image cover
  final double? coloredContainerHeight;

  /// padding for the title & subtitle section of the project item
  final EdgeInsetsGeometry? padding;

  /// callback for when view project is tapped
  final GestureTapCallback? onTap;

  @override
  _ProjectItemLgState createState() => _ProjectItemLgState();
}

class _ProjectItemLgState extends State<ProjectItemLg>
    with SingleTickerProviderStateMixin {
  bool _isHovering = false;
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: widget.duration);
    super.initState();
  }

  void _mouseEnter(bool hovering) {
    if (hovering) {
      setState(() {
        _isHovering = hovering;
        _controller.forward();
      });
    } else {
      setState(() {
        _isHovering = hovering;
        _controller.reverse();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Largeur et hauteur fixes pour alignement parfait
    double projectItemWidth = widthOfScreen(context);
    double projectItemHeight =
        widget.projectItemheight ?? 320; // Hauteur fixe pour tous

    TextTheme textTheme = Theme.of(context).textTheme;

    TextStyle? buttonStyle = textTheme.bodyMedium?.copyWith(
      color: Colors.white, // Texte du bouton en blanc
      fontSize: responsiveSize(
        context,
        Sizes.TEXT_SIZE_14,
        Sizes.TEXT_SIZE_16,
        md: Sizes.TEXT_SIZE_14,
      ),
      fontWeight: FontWeight.w500,
    );

    TextStyle? defaultNumberStyle =
        widget.projectNumberStyle ??
        textTheme.bodySmall?.copyWith(
          fontSize: _isHovering ? Sizes.TEXT_SIZE_20 : Sizes.TEXT_SIZE_16,
          color: Colors.white,
          fontWeight: _isHovering ? FontWeight.w400 : FontWeight.w300,
        );

    TextStyle? defaultTitleStyle =
        widget.titleStyle ??
        textTheme.bodySmall?.copyWith(
          color: Colors.white,
          fontSize: responsiveSize(context, 24, 40, md: 36, sm: 30),
        );

    TextStyle? defaultSubtitleStyle =
        widget.subtitleStyle ??
        textTheme.bodyMedium?.copyWith(
          color: Colors.white70,
          fontSize: 13,
          fontWeight: FontWeight.w400,
          letterSpacing: 2.5,
        );

    return MouseRegion(
      onEnter: (e) => _mouseEnter(true),
      onExit: (e) => _mouseEnter(false),
      child: SizedBox(
        height: projectItemHeight,
        width: projectItemWidth,
        child: AnimatedContainer(
          duration: widget.duration,
          color: _isHovering
              ? widget.backgroundOnHoverColor
              : widget.backgroundColor,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image à gauche

              // Infos à droite
              Expanded(
                child: Padding(
                  padding:
                      widget.padding ??
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 40),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Bloc numéro, trait, titre, catégorie
                      Expanded(
                        child: AnimatedSlide(
                          offset: _isHovering
                              ? const Offset(0.03, 0)
                              : Offset.zero,
                          duration: widget.duration,
                          curve: Curves.easeOut,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ProjectData(
                                duration: const Duration(milliseconds: 400),
                                projectNumber: widget.projectNumber,
                                indicatorWidth: _isHovering
                                    ? assignWidth(context, 0.18)
                                    : assignWidth(context, 0.12),
                                leadingMargin: EdgeInsets.only(
                                  right: Sizes.MARGIN_8,
                                ),
                                indicatorMargin: EdgeInsets.only(
                                  right: Sizes.MARGIN_8,
                                ),
                                title: widget.title,
                                subtitle: widget.subtitle,
                                subtitleStyle: defaultSubtitleStyle,
                                titleStyle: defaultTitleStyle,
                                projectNumberStyle: defaultNumberStyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Bouton à droite, centré verticalement
                      Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          // Image rectangle, animée, prend tout l'espace à droite, SANS coins arrondis
                          AnimatedPositioned(
                            duration: const Duration(milliseconds: 350),
                            curve: Curves.easeOut,
                            right: 0,
                            top: 0,
                            bottom: 0,
                            width: _isHovering ? 420 : 260, // Largeur augmentée
                            child: AnimatedScale(
                              scale: _isHovering ? 1.1 : 1.0,
                              duration: const Duration(milliseconds: 350),
                              curve: Curves.easeOut,
                              child: ColorFiltered(
                                colorFilter: _isHovering
                                    ? const ColorFilter.mode(
                                        Colors.transparent,
                                        BlendMode.multiply,
                                      )
                                    : const ColorFilter.matrix([
                                        // Matrice noir et blanc/beige
                                        0.36, 0.54, 0.10, 0, 30, // R
                                        0.36, 0.54, 0.10, 0, 24, // G
                                        0.36, 0.54, 0.10, 0, 12, // B
                                        0, 0, 0, 1, 0, // A
                                      ]),
                                child: Image.asset(
                                  widget.imageUrl,
                                  fit: BoxFit.cover,
                                  height: double.infinity,
                                  width: double.infinity,
                                  alignment: Alignment.centerRight,
                                ),
                              ),
                            ),
                          ),
                          // Bouton "View Project"
                          Align(
                            alignment: Alignment.center,
                            child: AnimatedBubbleButton(
                              startWidth: startWidthOfButton,
                              hovering: _isHovering,
                              controller: _controller,
                              duration: widget.duration,
                              controlsOwnAnimation: false,
                              height: heightOfButton,
                              targetWidth: targetWidthOfButton,
                              startBorderRadius: const BorderRadius.all(
                                Radius.circular(100.0),
                              ),
                              title: StringConst.VIEW_PROJECT.toUpperCase(),
                              color: _isHovering
                                  ? Colors.black
                                  : const Color(0xFF232323),
                              titleStyle: buttonStyle,
                              imageColor: Colors.white,
                              onTap: widget.onTap,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProjectItemSm extends StatefulWidget {
  const ProjectItemSm({
    super.key,
    required this.projectNumber,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.containerColor,
    this.buttonTitle = StringConst.VIEW,
    this.projectNumberStyle,
    this.subtitleStyle,
    this.titleStyle,
    this.coloredContainerHeight,
    this.coloredContainerWidth,
    this.imageWidth,
    this.imageHeight,
    this.duration = const Duration(milliseconds: 350),
    this.onTap,
  });

  final String projectNumber;
  final String title;
  final String subtitle;
  final String imageUrl;
  final String buttonTitle;
  final TextStyle? projectNumberStyle;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final Color containerColor;
  final Duration duration;
  final double? imageWidth;
  final double? imageHeight;
  final double? coloredContainerWidth;
  final double? coloredContainerHeight;

  /// callback for when view project is tapped
  final GestureTapCallback? onTap;

  @override
  _ProjectItemSmState createState() => _ProjectItemSmState();
}

class _ProjectItemSmState extends State<ProjectItemSm>
    with SingleTickerProviderStateMixin {
  bool _isHovering = false;
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: widget.duration);
    super.initState();
  }

  void _mouseEnter(bool hovering) {
    if (hovering) {
      setState(() {
        _isHovering = hovering;
        _controller.forward();
      });
    } else {
      setState(() {
        _isHovering = hovering;
        _controller.reverse();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // takes full width of screen
    double projectItemWidth = widthOfScreen(context);
    // takes 40% of the height of the device
    double heightOfProjectImageCover =
        widget.imageHeight ?? assignHeight(context, 0.3);
    // takes 90% of the width of the device
    double widthOfProjectImageCover =
        widget.imageWidth ?? assignWidth(context, 0.9);
    // takes 30% of the height of the device
    double heightOfColoredContainer =
        widget.coloredContainerHeight ?? assignHeight(context, 0.3);
    // takes 80% of the width of the device
    double widthOfColoredContainer =
        widget.coloredContainerWidth ?? assignWidth(context, 0.8);
    // this positions the colored container at the middle of the cover image.
    double positionOfColoredContainer = heightOfProjectImageCover / 2;
    TextTheme textTheme = Theme.of(context).textTheme;
    // textStyle for button for viewing project
    TextStyle? buttonStyle = textTheme.bodyMedium?.copyWith(
      color: AppColors.black,
      fontSize: Sizes.TEXT_SIZE_14,
      fontWeight: FontWeight.w500,
    );
    // textStyle for the current number or position of project in the list
    TextStyle? defaultNumberStyle =
        widget.projectNumberStyle ??
        textTheme.bodyMedium?.copyWith(
          fontSize: _isHovering ? Sizes.TEXT_SIZE_18 : Sizes.TEXT_SIZE_16,
          color: AppColors.grey550,
          fontWeight: _isHovering ? FontWeight.w400 : FontWeight.w300,
        );
    // textStyle for the title or name of the project
    TextStyle? defaultTitleStyle =
        widget.titleStyle ??
        textTheme.bodyMedium?.copyWith(color: AppColors.black, fontSize: 26);
    // textStyle for the subtitle (describing project platform) of the project
    TextStyle? defaultSubtitleStyle =
        widget.subtitleStyle ??
        textTheme.bodyMedium?.copyWith(
          color: AppColors.grey700,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          letterSpacing: 2.5,
        );

    return MouseRegion(
      onEnter: (e) => _mouseEnter(true),
      onExit: (e) => _mouseEnter(false),
      child: SizedBox(
        width: projectItemWidth,
        child: Column(
          children: [
            SizedBox(
              height:
                  heightOfProjectImageCover +
                  (heightOfColoredContainer - positionOfColoredContainer),
              child: Stack(
                children: [
                  Positioned(
                    top: positionOfColoredContainer,
                    child: Container(
                      width: widthOfColoredContainer,
                      color: widget.containerColor,
                      height: heightOfColoredContainer,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: Transform(
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.0095)
                        ..rotateY(0.085),
                      child: Image.asset(
                        widget.imageUrl,
                        width: widthOfProjectImageCover,
                        height: heightOfProjectImageCover,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SpaceH12(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ProjectData(
                  duration: widget.duration,
                  projectNumber: widget.projectNumber,
                  indicatorWidth: assignWidth(context, 0.12),
                  leadingMargin: EdgeInsets.only(
                    top:
                        (defaultTitleStyle!.fontSize! -
                            defaultNumberStyle!.fontSize!) /
                        2.5,
                    right: Sizes.MARGIN_8,
                  ),
                  indicatorMargin: EdgeInsets.only(
                    top: defaultNumberStyle.fontSize! / 2.5,
                    right: Sizes.MARGIN_8,
                  ),
                  title: widget.title,
                  subtitle: widget.subtitle,
                  subtitleStyle: defaultSubtitleStyle,
                  titleStyle: defaultTitleStyle,
                  projectNumberStyle: defaultNumberStyle,
                ),
              ],
            ),
            SpaceH16(),
            Container(
              margin: EdgeInsets.only(right: 30),
              child: Align(
                alignment: Alignment.centerRight,
                child: AnimatedBubbleButton(
                  startWidth: startWidthOfButtonSm,
                  hovering: _isHovering,
                  controller: _controller,
                  duration: widget.duration,
                  height: startWidthOfButtonSm,
                  targetWidth: targetWidthSm,
                  controlsOwnAnimation: false,
                  startBorderRadius: const BorderRadius.all(
                    Radius.circular(100.0),
                  ),
                  title: StringConst.VIEW_PROJECT.toUpperCase(),
                  color: AppColors.grey100,
                  titleStyle: buttonStyle,
                  imageColor: AppColors.black,
                  onTap: widget.onTap,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: library_private_types_in_public_api, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../core/adaptive.dart';
import '../sections/pages/works_page.dart';
import '../values/values.dart';
import 'animated_bubble_button.dart';
import 'animated_positioned_text.dart';
import 'animated_positioned_widget.dart';
import 'animated_slide_transtion.dart';
import 'animated_text_slide_box_transition.dart';
import 'scroll_down.dart';
import 'social.dart';
import 'spaces.dart';

const kDuration = Duration(milliseconds: 600);

class HomePageHeader extends StatefulWidget {
  const HomePageHeader({
    super.key,
    required this.scrollToWorksKey,
    required this.controller,
  });

  final GlobalKey scrollToWorksKey;
  final AnimationController controller;
  @override
  _HomePageHeaderState createState() => _HomePageHeaderState();
}

class _HomePageHeaderState extends State<HomePageHeader>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late AnimationController rotationController;
  late AnimationController scrollDownButtonController;
  late AnimationController whiteCircleController;
  late Animation<Offset> animation;
  late Animation<Offset> scrollDownBtnAnimation;
  late Animation<double> whiteCircleScaleAnimation;
  late Animation<Offset> whiteCircleOffsetAnimation;

  @override
  void initState() {
    scrollDownButtonController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    rotationController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );
    animation = Tween<Offset>(
      begin: Offset(0, 0.05),
      end: Offset(0, -0.05),
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));
    whiteCircleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    whiteCircleScaleAnimation = Tween<double>(begin: 0.7, end: 1.25).animate(
      CurvedAnimation(parent: whiteCircleController, curve: Curves.easeOutBack),
    );
    whiteCircleOffsetAnimation =
        Tween<Offset>(
          begin: const Offset(-0.1, 0),
          end: const Offset(0.25, 0),
        ).animate(
          CurvedAnimation(
            parent: whiteCircleController,
            curve: Curves.easeOutCubic,
          ),
        );

    rotationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        rotationController.reset();
        rotationController.forward();
      }
    });
    controller.forward(); // Lance l'animation une seule fois
    rotationController.forward();
    whiteCircleController.forward();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    scrollDownButtonController.dispose();
    rotationController.dispose();
    whiteCircleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = widthOfScreen(context);
    final double screenHeight = heightOfScreen(context);
    final EdgeInsets textMargin = EdgeInsets.only(
      left: responsiveSize(
        context,
        20,
        screenWidth * 0.15,
        sm: screenWidth * 0.15,
      ),
      top: responsiveSize(
        context,
        60,
        screenHeight * 0.35,
        sm: screenHeight * 0.35,
      ),
      bottom: responsiveSize(context, 20, 40),
    );
    final EdgeInsets padding = EdgeInsets.symmetric(
      horizontal: screenWidth * 0.1,
      vertical: screenHeight * 0.1,
    );
    final EdgeInsets imageMargin = EdgeInsets.only(
      right: responsiveSize(
        context,
        20,
        screenWidth * 0.05,
        sm: screenWidth * 0.05,
      ),
      top: responsiveSize(
        context,
        30,
        screenHeight * 0.25,
        sm: screenHeight * 0.25,
      ),
      bottom: responsiveSize(context, 20, 40),
    );

    return Container(
      width: screenWidth,
      color: AppColors.accentColor2.withOpacity(0.35),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: assignHeight(context, 0.2)),
            child: Align(
              alignment: Alignment.topCenter,
              child: AnimatedBuilder(
                animation: whiteCircleController,
                builder: (context, child) {
                  return FractionalTranslation(
                    translation: whiteCircleOffsetAnimation.value,
                    child: Transform.scale(
                      scale: whiteCircleScaleAnimation.value,
                      child: WhiteCircle(),
                    ),
                  );
                },
              ),
            ),
          ),
          ResponsiveBuilder(
            builder: (context, sizingInformation) {
              double screenWidth = sizingInformation.screenSize.width;
              if (screenWidth < RefinedBreakpoints().tabletNormal) {
                return Column(
                  children: [
                    Container(
                      padding: padding,
                      child: Image.asset(
                        ImagePath.William_home,
                        width: screenWidth,
                      ),
                    ),
                    Container(
                      padding: padding.copyWith(top: 0),
                      child: SizedBox(
                        width: screenWidth,
                        child: AboutDev(
                          controller: widget.controller,
                          width: screenWidth,
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return Stack(
                  children: [
                    // Trait horizontal en haut (desktop uniquement)
                    Positioned(
                      left: 0,
                      top: kToolbarHeight + 20,
                      child: Container(
                        width: screenWidth,
                        height: 1.5,
                        color: Colors.black,
                      ),
                    ),
                    // Trait vertical à gauche, aligné à la marge, qui coupe le trait horizontal
                    Positioned(
                      left:
                          textMargin.left / 2 -
                          0.75, // centre le trait vertical dans la marge
                      top: 0,
                      bottom: 0,
                      child: Container(width: 1.5, color: Colors.black),
                    ),
                    // Flèche noire animée qui arrive du bas droit puis reste fixe
                    AnimatedBuilder(
                      animation: controller,
                      builder: (context, child) {
                        // Animation de slide de bas droite vers la position finale
                        final slide =
                            Tween<Offset>(
                              begin: const Offset(
                                0.4,
                                1.0,
                              ), // arrive du bas droit
                              end: Offset.zero,
                            ).animate(
                              CurvedAnimation(
                                parent: controller,
                                curve: Curves.fastOutSlowIn,
                              ),
                            );
                        final opacity = controller.value.clamp(0.0, 1.0);

                        return Positioned(
                          left: textMargin.left / 2 - 0.75,
                          top: kToolbarHeight + 20 + 1.5,
                          child: Opacity(
                            opacity: opacity,
                            child: SlideTransition(
                              position: slide,
                              child: Transform.rotate(
                                angle: -0.75,
                                child: Icon(
                                  Icons.arrow_upward,
                                  color: Colors.black,
                                  size: 50,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    // Le contenu principal
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Espace de la marge gauche (pour garder la structure)
                        SizedBox(width: textMargin.left),
                        // Bloc AboutDev sans la marge gauche (déjà prise par SizedBox)
                        Container(
                          margin: textMargin.copyWith(left: 0),
                          child: SizedBox(
                            width: screenWidth * 0.40,
                            child: AboutDev(
                              controller: widget.controller,
                              width: screenWidth * 0.40,
                            ),
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.05),
                        // Remplace AnimatedSlideTranstion par Image.asset ici aussi :
                        Container(
                          margin: imageMargin,
                          child: Image.asset(
                            ImagePath.William_home,
                            width: screenWidth * 0.35,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }
            },
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: ResponsiveBuilder(
              builder: (context, sizingInformation) {
                double screenWidth = sizingInformation.screenSize.width;
                if (screenWidth < RefinedBreakpoints().tabletNormal) {
                  return Container();
                } else {
                  return InkWell(
                    hoverColor: Colors.transparent,
                    onTap: () {
                      Scrollable.ensureVisible(
                        widget.scrollToWorksKey.currentContext!,
                        duration: kDuration,
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 24, bottom: 40),
                      child: MouseRegion(
                        onEnter: (e) => scrollDownButtonController.forward(),
                        onExit: (e) => scrollDownButtonController.reverse(),
                        child: AnimatedSlideTranstion(
                          controller: scrollDownButtonController,
                          beginOffset: Offset(0, 0),
                          targetOffset: Offset(0, 0.1),
                          child: ScrollDownButton(),
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class WhiteCircle extends StatelessWidget {
  const WhiteCircle({super.key});

  @override
  Widget build(BuildContext context) {
    final widthOfCircle = responsiveSize(
      context,
      widthOfScreen(context) * 0.6, // Agrandi le cercle
      widthOfScreen(context) * 0.4,
    );
    return IgnorePointer(
      child: Lottie.asset(
        ImagePath.shape,
        width: widthOfCircle,
        height: widthOfCircle,
        fit: BoxFit.cover,
      ),
    );
  }
}

class AboutDev extends StatefulWidget {
  const AboutDev({super.key, required this.controller, required this.width});

  final AnimationController controller;
  final double width;

  @override
  _AboutDevState createState() => _AboutDevState();
}

class _AboutDevState extends State<AboutDev> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    EdgeInsetsGeometry margin = const EdgeInsets.only(left: 16);
    final CurvedAnimation curvedAnimation = CurvedAnimation(
      parent: widget.controller,
      curve: Interval(0.6, 1.0, curve: Curves.fastOutSlowIn),
    );
    double headerFontSize = responsiveSize(context, 28, 48, md: 36, sm: 32);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: margin,
          child: AnimatedTextSlideBoxTransition(
            controller: widget.controller,
            text: StringConst.HI,
            width: widget.width,
            maxLines: 3,
            textStyle: textTheme.bodyMedium?.copyWith(
              color: AppColors.black,
              fontSize: headerFontSize,
            ),
            color: AppColors.surface,
          ),
        ),
        SpaceH12(),
        Container(
          margin: margin,
          child: AnimatedTextSlideBoxTransition(
            controller: widget.controller,
            text: StringConst.DEV_INTRO,
            width: widget.width,
            maxLines: 3,
            textStyle: textTheme.bodyMedium?.copyWith(
              color: AppColors.black,
              fontSize: headerFontSize,
            ),
            color: AppColors.surface,
          ),
        ),
        SpaceH12(),
        Container(
          margin: margin,
          child: AnimatedTextSlideBoxTransition(
            controller: widget.controller,
            text: StringConst.DEV_TITLE,
            width: responsiveSize(
              context,
              widget.width * 0.75,
              widget.width,
              md: widget.width,
              sm: widget.width,
            ),
            maxLines: 3,
            textStyle: textTheme.bodyLarge?.copyWith(
              color: AppColors.black,
              fontSize: headerFontSize,
            ),
            color: AppColors.surface,
          ),
        ),
        SpaceH30(),
        Container(
          margin: margin,
          child: AnimatedPositionedText(
            controller: curvedAnimation,
            width: widget.width,
            maxLines: 3,
            factor: 2,
            text: StringConst.DEV_DESC,
            textStyle: textTheme.bodyMedium?.copyWith(
              fontSize: responsiveSize(
                context,
                Sizes.TEXT_SIZE_16,
                Sizes.TEXT_SIZE_18,
              ),
              height: 2,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        SpaceH30(),
        AnimatedPositionedWidget(
          controller: curvedAnimation,
          width: 200,
          height: 60,
          child: AnimatedBubbleButton(
            color: AppColors.surface,
            imageColor: AppColors.black,
            startOffset: Offset(0, 0),
            targetOffset: Offset(0.1, 0),
            targetWidth: 200,
            startBorderRadius: const BorderRadius.all(Radius.circular(100.0)),
            title: StringConst.MY_PROJECTS.toUpperCase(),
            titleStyle: textTheme.bodyMedium?.copyWith(
              color: AppColors.black,
              fontSize: responsiveSize(
                context,
                Sizes.TEXT_SIZE_14,
                Sizes.TEXT_SIZE_16,
                sm: Sizes.TEXT_SIZE_15,
              ),
              fontWeight: FontWeight.w500,
            ),
            onTap: () {
              Navigator.pushNamed(context, WorksPage.worksPageRoute);
            },
          ),
        ),
        SpaceH24(),
        Container(
          margin: margin,
          child: Socials(socialData: Data.socialData, color: AppColors.black),
        ),
      ],
    );
  }
}

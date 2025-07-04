// ignore_for_file: library_private_types_in_public_api

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../core/adaptive.dart';
import '../../core/functions.dart';
import '../../values/values.dart';
import '../../widgets/about_header.dart';
import '../../widgets/animated_footer.dart';
import '../../widgets/animated_line_through_text.dart';
import '../../widgets/animated_positioned_text.dart';
import '../../widgets/animated_text_slide_box_transition.dart';
import '../../widgets/content_area.dart';
import '../../widgets/content_builder.dart';
import '../../widgets/custom_spacer.dart';
import '../../widgets/page_wrapper.dart';
import '../../widgets/social.dart';
import '../../widgets/spaces.dart';
import '../../widgets/technology_section.dart';

class AboutPage extends StatefulWidget {
  static const String aboutPageRoute = StringConst.ABOUT_PAGE;
  const AboutPage({super.key});

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _storyController;
  late AnimationController _technologyController;
  late AnimationController _contactController;
  late AnimationController _technologyListController;
  late AnimationController _quoteController;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _storyController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _technologyController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _technologyListController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _contactController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _quoteController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _storyController.dispose();
    _technologyController.dispose();
    _technologyListController.dispose();
    _contactController.dispose();
    _quoteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double contentAreaWidth = responsiveSize(
      context,
      assignWidth(context, 0.75),
      assignWidth(context, 0.75),
      sm: assignWidth(context, 0.8),
    );
    EdgeInsetsGeometry padding = EdgeInsets.only(
      left: responsiveSize(
        context,
        assignWidth(context, 0.10),
        assignWidth(context, 0.15),
      ),
      right: responsiveSize(
        context,
        assignWidth(context, 0.10),
        assignWidth(context, 0.10),
        // sm: assignWidth(context, 0.10),
      ),
      top: responsiveSize(
        context,
        assignHeight(context, 0.15),
        assignHeight(context, 0.15),
        // sm: assignWidth(context, 0.10),
      ),
    );

    TextTheme textTheme = Theme.of(context).textTheme;
    TextStyle? bodyText1Style = textTheme.bodyLarge?.copyWith(
      fontSize: Sizes.TEXT_SIZE_18,
      color: AppColors.grey750,
      fontWeight: FontWeight.w400,
      height: 2.0,
      // letterSpacing: 2,
    );
    TextStyle? bodyText2Style = textTheme.bodyMedium?.copyWith(
      color: AppColors.grey750,
    );
    TextStyle? titleStyle = textTheme.bodySmall?.copyWith(
      color: AppColors.black,
      fontSize: responsiveSize(context, Sizes.TEXT_SIZE_16, Sizes.TEXT_SIZE_20),
    );
    CurvedAnimation storySectionAnimation = CurvedAnimation(
      parent: _storyController,
      curve: Interval(0.6, 1.0, curve: Curves.ease),
    );
    CurvedAnimation technologySectionAnimation = CurvedAnimation(
      parent: _technologyController,
      curve: Interval(0.6, 1.0, curve: Curves.fastOutSlowIn),
    );
    double widthOfBody = responsiveSize(
      context,
      assignWidth(context, 0.55),
      assignWidth(context, 0.3),
    );
    return PageWrapper(
      selectedRoute: AboutPage.aboutPageRoute,
      selectedPageName: "",
      navBarAnimationController: _controller,
      onLoadingAnimationDone: () {
        _controller.forward();
      },
      child: ListView(
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        children: [
          Padding(
            padding: padding,
            child: ContentArea(
              width: contentAreaWidth,
              child: Column(
                children: [
                  AboutHeader(width: contentAreaWidth, controller: _controller),
                  CustomSpacer(heightFactor: 0.1),
                  VisibilityDetector(
                    key: Key('story-section'),
                    onVisibilityChanged: (visibilityInfo) {
                      double visiblePercentage =
                          visibilityInfo.visibleFraction * 100;
                      if (visiblePercentage >
                          responsiveSize(context, 40, 70, md: 50)) {
                        _storyController.forward();
                      }
                    },
                    child: ContentBuilder(
                      controller: _storyController,
                      number: "/01 ",
                      width: contentAreaWidth,
                      section: StringConst.ABOUT_DEV_STORY.toUpperCase(),
                      title: StringConst.ABOUT_DEV_STORY_TITLE,
                      body: LayoutBuilder(
                        builder: (context, constraints) {
                          final isMobile =
                              constraints.maxWidth <
                              RefinedBreakpoints().tabletSmall;
                          final carouselHeight = isMobile
                              ? assignHeight(context, 0.35)
                              : assignHeight(context, 0.55);
                          final carouselWidth = isMobile
                              ? constraints.maxWidth
                              : constraints.maxWidth * 0.43;

                          return Flex(
                            direction: isMobile
                                ? Axis.vertical
                                : Axis.horizontal,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Paragraphes à gauche sur desktop, au-dessus sur mobile
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    AnimatedPositionedText(
                                      controller: storySectionAnimation,
                                      width: widthOfBody,
                                      maxLines: 30,
                                      text:
                                          StringConst.ABOUT_DEV_STORY_CONTENT_1,
                                      textStyle: bodyText1Style?.copyWith(
                                        height: 2,
                                      ),
                                      textAlign: TextAlign.justify,
                                    ),
                                    AnimatedPositionedText(
                                      controller: storySectionAnimation,
                                      width: widthOfBody,
                                      maxLines: 30,
                                      text:
                                          StringConst.ABOUT_DEV_STORY_CONTENT_2,
                                      textStyle: bodyText1Style?.copyWith(
                                        height: 2,
                                      ),
                                      textAlign: TextAlign.justify,
                                    ),
                                    AnimatedPositionedText(
                                      controller: storySectionAnimation,
                                      width: widthOfBody,
                                      maxLines: 30,
                                      text:
                                          StringConst.ABOUT_DEV_STORY_CONTENT_3,
                                      textStyle: bodyText1Style?.copyWith(
                                        height: 2,
                                      ),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: isMobile ? 0 : 32,
                                height: isMobile ? 24 : 0,
                              ),
                              // Carousel à droite sur desktop, en dessous sur mobile
                              AnimatedBuilder(
                                animation: storySectionAnimation,
                                builder: (context, child) {
                                  return Opacity(
                                    opacity: storySectionAnimation.value,
                                    child: child,
                                  );
                                },
                                child: SizedBox(
                                  width: carouselWidth,
                                  height: carouselHeight,
                                  child: CarouselSlider(
                                    options: CarouselOptions(
                                      height: carouselHeight,
                                      viewportFraction: 1,
                                      autoPlay: true,
                                      autoPlayInterval: const Duration(
                                        seconds: 3,
                                      ),
                                      enlargeCenterPage: true,
                                      enableInfiniteScroll: true,
                                      scrollDirection: Axis.horizontal,
                                      aspectRatio: isMobile ? 1.5 : 0.8,
                                    ),
                                    items:
                                        [
                                          ImagePath.carousel1,
                                          ImagePath.carousel2,
                                          ImagePath.carousel3,
                                          ImagePath.carousel4,
                                          ImagePath.carousel5,
                                          ImagePath.carousel6,
                                        ].map((imgPath) {
                                          return ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              24,
                                            ),
                                            child: Image.asset(
                                              imgPath,
                                              fit: BoxFit.cover,
                                              width: double.infinity,
                                              height: double.infinity,
                                            ),
                                          );
                                        }).toList(),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  CustomSpacer(heightFactor: 0.1),
                  VisibilityDetector(
                    key: Key('technology-section'),
                    onVisibilityChanged: (visibilityInfo) {
                      double visiblePercentage =
                          visibilityInfo.visibleFraction * 100;
                      if (visiblePercentage > 50) {
                        _technologyController.forward();
                      }
                    },
                    child: ContentBuilder(
                      controller: _technologyController,
                      number: "/02 ",
                      width: contentAreaWidth,
                      section: StringConst.ABOUT_DEV_TECHNOLOGY.toUpperCase(),
                      title: StringConst.ABOUT_DEV_TECHNOLOGY_TITLE,
                      body: Column(
                        children: [
                          AnimatedPositionedText(
                            controller: technologySectionAnimation,
                            width: widthOfBody,
                            maxLines: 12,
                            text: StringConst.ABOUT_DEV_TECHNOLOGY_CONTENT,
                            textStyle: bodyText1Style,
                          ),
                        ],
                      ),
                      footer: VisibilityDetector(
                        key: Key('technology-list'),
                        onVisibilityChanged: (visibilityInfo) {
                          double visiblePercentage =
                              visibilityInfo.visibleFraction * 100;
                          if (visiblePercentage > 60) {
                            _technologyListController.forward();
                          }
                        },
                        child: Column(
                          children: [
                            SpaceH12(),
                            TechnologySection(
                              width: contentAreaWidth,
                              controller: _technologyListController,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  CustomSpacer(heightFactor: 0.1),
                  VisibilityDetector(
                    key: Key('contact-section'),
                    onVisibilityChanged: (visibilityInfo) {
                      double visiblePercentage =
                          visibilityInfo.visibleFraction * 100;
                      if (visiblePercentage > 50) {
                        _contactController.forward();
                      }
                    },
                    child: ContentBuilder(
                      controller: _contactController,
                      number: "/03 ",
                      width: contentAreaWidth,
                      section: StringConst.ABOUT_DEV_CONTACT.toUpperCase(),
                      title: StringConst.ABOUT_DEV_CONTACT_SOCIAL,
                      body: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SpaceH20(),
                          Wrap(
                            spacing: 20,
                            runSpacing: 20,
                            children: _buildSocials(Data.socialData2),
                          ),
                        ],
                      ),
                      footer: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SpaceH40(),
                          AnimatedTextSlideBoxTransition(
                            controller: _contactController,
                            text: StringConst.ABOUT_DEV_CONTACT_EMAIL,
                            textStyle: titleStyle,
                            color: AppColors.background,
                          ),
                          SpaceH40(),
                          AnimatedLineThroughText(
                            text: StringConst.DEV_EMAIL,
                            hasSlideBoxAnimation: true,
                            controller: _contactController,
                            onTap: () {
                              Functions.launchUrl(StringConst.EMAIL_URL);
                            },
                            textStyle: bodyText2Style,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SpaceH36(),
                ],
              ),
            ),
          ),
          // SlidingBanner(),
          AnimatedFooter(),
        ],
      ),
    );
  }

  List<Widget> _buildSocials(List<SocialData> data) {
    TextTheme textTheme = Theme.of(context).textTheme;
    TextStyle? style = textTheme.bodyMedium?.copyWith(color: AppColors.grey750);
    TextStyle? slashStyle = textTheme.bodyMedium?.copyWith(
      color: AppColors.grey750,
      fontWeight: FontWeight.w400,
      fontSize: 18,
    );
    List<Widget> items = [];

    for (int index = 0; index < data.length; index++) {
      items.add(
        AnimatedLineThroughText(
          text: data[index].name,
          isUnderlinedByDefault: true,
          controller: _contactController,
          hasSlideBoxAnimation: true,
          isUnderlinedOnHover: false,
          onTap: () {
            Functions.launchUrl(data[index].url);
          },
          textStyle: style,
        ),
      );

      if (index < data.length - 1) {
        items.add(Text('/', style: slashStyle));
      }
    }

    return items;
  }
}

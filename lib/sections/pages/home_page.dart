// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:portfolio_flutter/core/adaptive.dart';
import 'package:portfolio_flutter/widgets/about_section.dart';
import 'package:portfolio_flutter/widgets/technology_section.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../values/values.dart';
import '../../widgets/animated_footer.dart';
import '../../widgets/home_page_header.dart';
import '../../widgets/loading_page.dart';
import '../../widgets/page_wrapper.dart';

class HomePage extends StatefulWidget {
  static const String homePageRoute = StringConst.HOME_PAGE;

  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  GlobalKey key = GlobalKey();
  final GlobalKey _galleryKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();
  late AnimationController _viewProjectsController;
  late AnimationController _slideTextController;
  late NavigationArguments _arguments;
  late AnimationController _technologyController;

  @override
  void initState() {
    _arguments = NavigationArguments();
    _viewProjectsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _slideTextController = AnimationController(
      vsync: this,
      duration: Animations.slideAnimationDurationLong,
    );
    _technologyController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    super.initState();
  }

  void getArguments() {
    final Object? args = ModalRoute.of(context)!.settings.arguments;
    if (args == null) {
      _arguments.showUnVeilPageAnimation = false;
    } else {
      _arguments = args as NavigationArguments;
    }
  }

  @override
  void dispose() {
    _viewProjectsController.dispose();
    _slideTextController.dispose();
    _scrollController.dispose();
    _technologyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    getArguments();
    TextTheme textTheme = Theme.of(context).textTheme;

    return PageWrapper(
      selectedRoute: HomePage.homePageRoute,
      selectedPageName: StringConst.HOME,
      navBarAnimationController: _slideTextController,
      appLogoColor: AppColors.white,
      hasSideTitle: false,
      hasUnveilPageAnimation: _arguments.showUnVeilPageAnimation,
      onLoadingAnimationDone: () {
        _slideTextController.forward();
      },
      customLoadingAnimation: LoadingHomePageAnimation(
        text: StringConst.WILLIAM_AGENEAU,
        style: textTheme.headlineLarge!.copyWith(color: AppColors.white),
        onLoadingDone: () {
          _slideTextController.forward();
        },
      ),
      child: ResponsiveBuilder(
        builder: (context, sizingInformation) {
          bool isMobile =
              sizingInformation.deviceScreenType == DeviceScreenType.mobile;
          double contentAreaWidth = isMobile
              ? assignWidth(context, 1.0)
              : assignWidth(context, 0.75);

          return ListView(
            padding: EdgeInsets.zero,
            controller: _scrollController,
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            children: [
              HomePageHeader(
                controller: _slideTextController,
                scrollToWorksKey: _galleryKey,
              ),
              Container(
                color: const Color(0xff171014),
                width: double.infinity,
                child: const AboutSection(),
              ),
              VisibilityDetector(
                key: const Key('technology-section'),
                onVisibilityChanged: (visibilityInfo) {
                  double visiblePercentage =
                      visibilityInfo.visibleFraction * 100;
                  if (visiblePercentage > 50) {
                    _technologyController.forward();
                  }
                },
                child: Container(
                  color: const Color(0xff171014),
                  width: double.infinity,
                  child: TechnologySection(
                    controller: _technologyController,
                    width: contentAreaWidth,
                  ),
                ),
              ),
              const AnimatedFooter(),
            ],
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:portfolio_flutter/core/adaptive.dart';
import 'package:portfolio_flutter/widgets/about_section.dart';
import 'package:portfolio_flutter/widgets/technology_section.dart';
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
  // ignore: library_private_types_in_public_api
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

  // Ajoute ce champ dans _HomePageState pour gérer le hover groupé :

  @override
  void initState() {
    _arguments = NavigationArguments();
    _viewProjectsController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
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
    // if page is being loaded for the first time, args will be null.
    // if args is null, I set boolean values to run the appropriate animation
    // In this case, if null run loading animation, if not null run the unveil animation
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
    TextTheme textTheme = Theme.of(context).textTheme;

    getArguments();
    return PageWrapper(
      selectedRoute: HomePage.homePageRoute,
      selectedPageName: StringConst.HOME,
      navBarAnimationController: _slideTextController,
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
      child: ListView(
        padding: EdgeInsets.zero,
        controller: _scrollController,
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        children: [
          HomePageHeader(
            controller: _slideTextController,
            scrollToWorksKey: _galleryKey, // Passe le key ici
          ),
          AboutSection(),
          VisibilityDetector(
            key: const Key('technology-section'),
            onVisibilityChanged: (visibilityInfo) {
              double visiblePercentage = visibilityInfo.visibleFraction * 100;
              if (visiblePercentage > 50) {
                _technologyController.forward(); // ✅ joue l’animation
              }
            },
            child: Container(
              color: const Color(0xff171014),
              child: TechnologySection(
                controller: _technologyController, // ✅ passe ton controller
                width: contentAreaWidth, // ✅ largeur responsive
              ),
            ),
          ),
          AnimatedFooter(),
        ],
      ),
    );
  }
}

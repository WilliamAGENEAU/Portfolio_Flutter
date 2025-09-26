import 'package:flutter/material.dart';

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

  // Déclare ta liste d'images (par exemple en haut de _HomePageState) :
  final List<String> recentProjectImages = [
    ImagePath.MARVEL_COVER,
    ImagePath.CHESS_3,
    ImagePath.MOTION_COVER,
    ImagePath.MUSEUM_COVER,
    ImagePath.MOTION_3,
    ImagePath.CHESS_5,
    ImagePath.MARVEL_BKG,
  ];

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
    getArguments();
    TextTheme textTheme = Theme.of(context).textTheme;
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

          AnimatedFooter(),
        ],
      ),
    );
  }
}

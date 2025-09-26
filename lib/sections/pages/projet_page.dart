import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../values/values.dart';
import '../../widgets/animated_footer.dart';
import '../../widgets/page_wrapper.dart';
import '../../widgets/gallery_guirlande.dart';

class ProjetPage extends StatefulWidget {
  static const String worksPageRoute = StringConst.WORKS_PAGE;
  const ProjetPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProjetPageState createState() => _ProjetPageState();
}

class _ProjetPageState extends State<ProjetPage> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _headingTextController;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    _headingTextController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1200),
    );

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _headingTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      selectedRoute: ProjetPage.worksPageRoute,
      selectedPageName: StringConst.PROJETS,
      navBarAnimationController: _headingTextController,
      hasSideTitle: false,
      onLoadingAnimationDone: () {
        _headingTextController.forward();
      },
      child: ListView(
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        children: [
          ResponsiveBuilder(
            builder: (context, sizingInformation) {
              double screenWidth = sizingInformation.screenSize.width;

              if (screenWidth <= RefinedBreakpoints().tabletSmall) {
                return Column(
                  children: [
                    GalleryGuirlande(
                      images: [
                        ImagePath.ELEVAGEY_TUBE,
                        ImagePath.MARVEL_TUBE,
                        ImagePath.MUSEUM_TUBE,
                        ImagePath.CHESS_TUBE,
                        ImagePath.MOTION_CTUBE,
                        ImagePath.INAZUMA_TUBE,
                      ],
                      projects: [
                        Projects.ELEVAGEY,
                        Projects.MARVEL,
                        Projects.MUSEUM_EDIBLE_EARTH,
                        Projects.CONNECTED_CHESSBOARD,
                        Projects.MOTION_DESIGN,
                        Projects.INAZUMA,
                      ],
                    ),
                  ],
                );
              } else {
                return Column(
                  children: [
                    GalleryGuirlande(
                      images: [
                        ImagePath.ELEVAGEY_TUBE,
                        ImagePath.MARVEL_TUBE,
                        ImagePath.MUSEUM_TUBE,
                        ImagePath.CHESS_TUBE,
                        ImagePath.MOTION_CTUBE,
                        ImagePath.INAZUMA_TUBE,
                      ],
                      projects: [
                        Projects.ELEVAGEY,
                        Projects.MARVEL,
                        Projects.MUSEUM_EDIBLE_EARTH,
                        Projects.CONNECTED_CHESSBOARD,
                        Projects.MOTION_DESIGN,
                        Projects.INAZUMA,
                      ],
                    ),
                  ],
                );
              }
            },
          ),
          AnimatedFooter(),
        ],
      ),
    );
  }
}

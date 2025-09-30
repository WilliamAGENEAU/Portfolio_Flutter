// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../core/adaptive.dart';
import '../../core/functions.dart';
import '../../values/values.dart';
import '../../widgets/about_project.dart';
import '../../widgets/animated_text_slide_box_transition.dart';
import '../../widgets/animated_wave.dart';
import '../../widgets/content_area.dart';
import '../../widgets/custom_spacer.dart';
import '../../widgets/empty.dart';
import '../../widgets/next_project.dart';
import '../../widgets/page_wrapper.dart';
import '../../widgets/project_item.dart';
import '../../widgets/simple_footer.dart';
import '../../widgets/spaces.dart';

class ProjectDetailArguments {
  final ProjectItemData data;
  final List<ProjectItemData> dataSource;
  final int currentIndex;
  final ProjectItemData? nextProject;
  final bool hasNextProject;

  ProjectDetailArguments({
    required this.dataSource,
    required this.data,
    required this.currentIndex,
    required this.hasNextProject,
    this.nextProject,
  });
}

class ProjectDetailPage extends StatefulWidget {
  static const String projectDetailPageRoute = StringConst.PROJECT_DETAIL_PAGE;
  const ProjectDetailPage({super.key});

  @override
  _ProjectDetailPageState createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _waveController;
  late AnimationController _aboutProjectController;
  late AnimationController _projectDataController;
  late ProjectDetailArguments projectDetails;
  double waveLineHeight = 100;
  bool _albumVisible = false;

  @override
  void initState() {
    _waveController = AnimationController(
      vsync: this,
      duration: Animations.waveDuration,
    )..repeat();
    _controller = AnimationController(
      vsync: this,
      duration: Animations.slideAnimationDurationLong,
    );
    _aboutProjectController = AnimationController(
      vsync: this,
      duration: Animations.slideAnimationDurationShort,
    );
    _waveController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _waveController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _waveController.forward();
      }
    });
    _projectDataController = AnimationController(
      vsync: this,
      duration: Animations.slideAnimationDurationShort,
    );
    _waveController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _waveController.dispose();
    _aboutProjectController.dispose();
    _controller.dispose();
    super.dispose();
  }

  ProjectDetailArguments getArguments() {
    projectDetails =
        ModalRoute.of(context)!.settings.arguments as ProjectDetailArguments;
    return projectDetails;
  }

  @override
  Widget build(BuildContext context) {
    getArguments();
    TextTheme textTheme = Theme.of(context).textTheme;

    // ✅ Titres & sous-titres forcés en blanc
    TextStyle? coverTitleStyle = textTheme.displayMedium?.copyWith(
      color: Colors.white,
      fontSize: 40,
    );
    TextStyle? coverSubtitleStyle = textTheme.bodyLarge?.copyWith(
      color: Colors.white,
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
        assignWidth(context, 0.25),
      ),
    );
    double contentAreaWidth = responsiveSize(
      context,
      assignWidth(context, 0.60),
      assignWidth(context, 0.80),
    );

    return PageWrapper(
      backgroundColor: const Color(0xff171014), // ✅ fond sombre cohérent
      selectedRoute: ProjectDetailPage.projectDetailPageRoute,
      hasSideTitle: false,
      selectedPageName: StringConst.PROJECT,
      navBarAnimationController: _controller,
      navBarTitleColor: Colors.white, // ✅ barre nav en blanc
      navBarSelectedTitleColor: Colors.white,
      appLogoColor: Colors.white,
      onLoadingAnimationDone: () {
        _controller.forward();
      },
      child: ListView(
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        children: [
          SizedBox(
            width: widthOfScreen(context),
            height: heightOfScreen(context),
            child: Stack(
              children: [
                // ✅ Image de couverture brute sans opacité
                Image.asset(
                  projectDetails.data.coverUrl,
                  fit: BoxFit.cover,
                  width: widthOfScreen(context),
                  height: heightOfScreen(context),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: waveLineHeight + 40),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedTextSlideBoxTransition(
                          controller: _controller,
                          widthFactor: 1.20,
                          text: "${projectDetails.data.title}.",
                          coverColor: projectDetails.data.primaryColor,
                          textStyle: coverTitleStyle,
                          textAlign: TextAlign.center,
                          color: Colors.white,
                        ),
                        SpaceH20(),
                        AnimatedTextSlideBoxTransition(
                          controller: _controller,
                          widthFactor: 1.20,
                          text: projectDetails.data.category,
                          coverColor: projectDetails.data.primaryColor,
                          textStyle: coverSubtitleStyle,
                          textAlign: TextAlign.center,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: AnimatedWaveLine(
                      height: waveLineHeight,
                      controller: _waveController,
                      color: projectDetails.data.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          CustomSpacer(heightFactor: 0.15),
          VisibilityDetector(
            key: const Key('about-project'),
            onVisibilityChanged: (visibilityInfo) {
              double visiblePercentage = visibilityInfo.visibleFraction * 100;
              if (visiblePercentage > 40) {
                _aboutProjectController.forward();
              }
            },
            child: Padding(
              padding: padding,
              child: ContentArea(
                width: contentAreaWidth,
                child: Aboutproject(
                  projectData: projectDetails.data,
                  controller: _aboutProjectController,
                  projectDataController: _projectDataController,
                  width: contentAreaWidth,
                ),
              ),
            ),
          ),
          CustomSpacer(heightFactor: 0.15),
          VisibilityDetector(
            key: const Key('project-album'),
            onVisibilityChanged: (visibilityInfo) {
              double visiblePercentage = visibilityInfo.visibleFraction * 100;
              if (visiblePercentage > 40 && !_albumVisible) {
                setState(() {
                  _albumVisible = true;
                });
              }
            },
            child: _albumVisible
                ? _buildProjectAlbum(projectDetails.data.projectAssets)
                : const SizedBox(height: 400),
          ),
          projectDetails.hasNextProject
              ? CustomSpacer(heightFactor: 0.15)
              : const Empty(),
          projectDetails.hasNextProject
              ? Padding(
                  padding: padding,
                  child: ContentArea(
                    width: contentAreaWidth,
                    child: NextProject(
                      width: contentAreaWidth,
                      nextProject: projectDetails.nextProject!,
                      navigateToNextProject: () {
                        Functions.navigateToProject(
                          context: context,
                          dataSource: projectDetails.dataSource,
                          currentProject: projectDetails.nextProject!,
                          currentProjectIndex: projectDetails.currentIndex + 1,
                        );
                      },
                    ),
                  ),
                )
              : const Empty(),
          projectDetails.hasNextProject
              ? CustomSpacer(heightFactor: 0.15)
              : const Empty(),
          const SimpleFooter(),
        ],
      ),
    );
  }

  Widget _buildProjectAlbum(List<String> data) {
    return AnimationLimiter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: data.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.2,
          ),
          itemBuilder: (context, index) {
            return AnimationConfiguration.staggeredGrid(
              position: index,
              duration: const Duration(milliseconds: 500),
              columnCount: 2,
              child: ScaleAnimation(
                child: FadeInAnimation(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(data[index], fit: BoxFit.cover),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
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
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth < 600; // ✅ seuil mobile
        int crossAxisCount = isMobile ? 1 : 2;

        return AnimationLimiter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              children: [
                // ✅ Grille normale sauf la dernière si impair
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: data.length.isEven ? data.length : data.length - 1,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 8, // ✅ serré
                    mainAxisSpacing: 8,
                    childAspectRatio: 1.2, // ✅ adaptable
                  ),
                  itemBuilder: (context, index) {
                    return AnimationConfiguration.staggeredGrid(
                      position: index,
                      duration: const Duration(milliseconds: 500),
                      columnCount: crossAxisCount,
                      child: ScaleAnimation(
                        child: FadeInAnimation(
                          child: _AlbumImage(
                            imagePath: data[index],
                            index: index,
                            allImages: data,
                          ),
                        ),
                      ),
                    );
                  },
                ),

                // ✅ Si impair → dernière image en grand pleine largeur
                if (data.isNotEmpty && data.length.isOdd)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: AnimationConfiguration.staggeredList(
                      position: data.length - 1,
                      duration: const Duration(milliseconds: 500),
                      child: ScaleAnimation(
                        child: FadeInAnimation(
                          child: AspectRatio(
                            aspectRatio: 16 / 9, // ✅ format large
                            child: _AlbumImage(
                              imagePath: data.last,
                              index: data.length - 1,
                              allImages: data,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _AlbumImage extends StatefulWidget {
  final String imagePath;
  final int index;
  final List<String> allImages;

  const _AlbumImage({
    required this.imagePath,
    required this.index,
    required this.allImages,
  });

  @override
  State<_AlbumImage> createState() => _AlbumImageState();
}

class _AlbumImageState extends State<_AlbumImage> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click, // ✅ souris clickable
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => _GalleryViewer(
                images: widget.allImages,
                initialIndex: widget.index,
              ),
            ),
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            fit: StackFit.expand,
            children: [
              AnimatedScale(
                duration: const Duration(milliseconds: 300),
                scale: _hovering ? 1.05 : 1.0, // ✅ zoom léger
                child: Image.asset(
                  widget.imagePath,
                  fit: BoxFit.cover, // ✅ couvre bien tout en restant net
                ),
              ),
              if (_hovering)
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: 0.2,
                  child: Container(color: Colors.black),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// ✅ Viewer fullscreen zoomable avec photo_view
class _GalleryViewer extends StatelessWidget {
  final List<String> images;
  final int initialIndex;

  const _GalleryViewer({required this.images, required this.initialIndex});

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController(initialPage: initialIndex);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PhotoViewGallery.builder(
            pageController: controller,
            itemCount: images.length,
            builder: (context, index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: AssetImage(images[index]),
                heroAttributes: PhotoViewHeroAttributes(tag: images[index]),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 3,
              );
            },
            loadingBuilder: (context, event) =>
                const Center(child: CircularProgressIndicator()),
          ),
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 32),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}
